{ config, ... }:
let
  domain = "irc.savitsky.dev";
in
{
  # Enable ACME for automatic TLS certificate management
  security.acme = {
    acceptTerms = true;
    defaults.email = "ilya@savitsky.dev";
    certs.${domain} = {
      domain = domain;
      group = "acme-certs";
      reloadServices = [ "soju.service" ];
    };
  };

  # Create a group for ACME certificates
  users.groups.acme-certs = { };

  # Add nginx user to the acme-certs group
  users.users.nginx.extraGroups = [ "acme-certs" ];

  # Open firewall ports for IRC with TLS and HTTP (for ACME challenge)
  networking.firewall.allowedTCPPorts = [
    80
    443
    6697
  ];

  # Configure soju IRC bouncer
  services.soju = {
    enable = true;
    hostName = domain;

    # Listen on standard IRC TLS port and localhost for WebSocket
    listen = [
      ":6697"
      "wss://localhost:8080"
    ];

    # Use ACME certificates
    tlsCertificate = "${config.security.acme.certs.${domain}.directory}/cert.pem";
    tlsCertificateKey = "${config.security.acme.certs.${domain}.directory}/key.pem";

    # Enable message logging
    enableMessageLogging = true;

    # Allow WebSocket connections from nginx reverse proxy
    httpOrigins = [ "https://${domain}" ];
  };

  # Grant the soju service access to certificates via supplementary group
  systemd.services.soju.serviceConfig.SupplementaryGroups = [ "acme-certs" ];

  # Configure nginx for WebSocket TLS termination
  services.nginx = {
    enable = true;

    virtualHosts.${domain} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://localhost:8080";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
