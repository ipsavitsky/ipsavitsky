{ config, ... }:

let
  # TODO: Replace with your actual domain
  matrixDomain = "matrix.savitsky.dev";

  # If using a separate server_name from the base URL (for .well-known delegation):
  # serverName = "savitsky.dev";
  serverName = matrixDomain;

  # TODO: Replace with your public IP
  publicIP = "0.0.0.0";
in
{
  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${matrixDomain}" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8008";
        extraConfig = ''
          client_max_body_size 50M;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_read_timeout 86400;
        '';
      };

      # .well-known delegation (needed if serverName != matrixDomain)
      # locations."= /.well-known/matrix/server".extraConfig = ''
      #   return 200 '{"m.server": "${matrixDomain}:443"}';
      #   add_header Content-Type application/json;
      # '';
    };
  };

  # Enable ACME for Let's Encrypt certificates
  security.acme = {
    acceptTerms = true;
    defaults.email = "ilya@savitsky.dev"; # TODO: Replace with your email
  };

  services.coturn = {
    enable = true;

    listening-port = 3478;
    tls-listening-port = 5349;

    realm = matrixDomain;

    # TLS certificates - reuse the ones from nginx/ACME
    cert = "${config.security.acme.certs.${matrixDomain}.directory}/fullchain.pem";
    pkey = "${config.security.acme.certs.${matrixDomain}.directory}/key.pem";

    lt-cred-mech = true;
    use-auth-secret = true;

    # TODO: Set the secret via sops and use static-auth-secret-file instead:
    # static-auth-secret-file = config.sops.secrets."coturn/static-auth-secret".path;
    static-auth-secret = "CHANGE_ME_COTURN_SECRET";

    extraConfig = ''
      fingerprint
      listening-ip=0.0.0.0
      # TODO: Replace with your public IP
      external-ip=${publicIP}
      no-multicast-peers
      no-tlsv1
      no-tlsv1_1
      no-cli
      denied-peer-ip=10.0.0.0-10.255.255.255
      denied-peer-ip=192.168.0.0-192.168.255.255
      denied-peer-ip=172.16.0.0-172.31.255.255
    '';
  };

  # Open firewall ports for coturn
  networking.firewall = {
    allowedTCPPorts = [
      80 # HTTP (for ACME)
      443 # HTTPS
      3478 # STUN/TURN
      5349 # TURNS
    ];
    allowedUDPPorts = [
      3478 # STUN/TURN
      5349 # TURNS
    ];
    allowedUDPPortRanges = [
      {
        from = 49152;
        to = 65535;
      } # TURN media relay ports
    ];
  };

  services.postgresql = {
    enable = true;

    # Create the synapse database and user
    ensureDatabases = [ "synapse" ];
    ensureUsers = [
      {
        name = "synapse";
        ensureDBOwnership = true;
      }
    ];
  };

  services.matrix-synapse = {
    enable = true;

    settings = {
      server_name = serverName;

      # TODO: Set real secrets via sops or extraConfigFiles
      registration_shared_secret = "CHANGE_ME_REGISTRATION_SECRET";
      macaroon_secret_key = "CHANGE_ME_MACAROON_SECRET";

      database = {
        name = "psycopg2";
        args = {
          database = "synapse";
          user = "synapse";
          host = "/run/postgresql";
          cp_min = 5;
          cp_max = 10;
        };
      };

      listeners = [
        {
          port = 8008;
          bind_addresses = [ "127.0.0.1" ];
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = false;
            }
          ];
          type = "http";
          tls = false;
          x_forwarded = true;
        }
      ];

      # Allow public rooms to be fetched
      allow_public_rooms_without_auth = true;
      allow_public_rooms_over_federation = true;

      # TURN configuration
      turn_uris = [
        "turn:${matrixDomain}?transport=udp"
        "turn:${matrixDomain}?transport=tcp"
        "turns:${matrixDomain}?transport=tcp"
      ];
      # TODO: Match this with coturn's static-auth-secret (use sops for both)
      turn_shared_secret = "CHANGE_ME_COTURN_SECRET";
      turn_user_lifetime = "1h";

      # Rate limiting
      rc_registration = {
        per_second = 0.17;
        burst_count = 3;
      };
      rc_login = {
        address = {
          per_second = 0.17;
          burst_count = 3;
        };
        account = {
          per_second = 0.17;
          burst_count = 3;
        };
      };

      # Federation
      federation_client_minimum_tls_version = "1.2";

      # Logging
      logConfig = {
        version = 1;
        formatters.journal.format = "%(name)s: [%(levelname)s] %(message)s";
        handlers.journal = {
          class = "systemd.journal.JournalHandler";
          formatter = "journal";
          SYSLOG_IDENTIFIER = "synapse";
        };
        root = {
          level = "INFO";
          handlers = [ "journal" ];
        };
        disable_existing_loggers = false;
      };
    };

    # Extra config files (useful for secrets via environmentFile)
    # extraConfigFiles = [
    #   config.sops.secrets."synapse/extra-config".path
    # ];
  };

  # TODO: Uncomment when secrets are in sops
  # sops.secrets = {
  #   "synapse/registration_shared_secret" = {
  #     owner = "synapse";
  #   };
  #   "synapse/macaroon_secret_key" = {
  #     owner = "synapse";
  #   };
  #   "coturn/static-auth-secret" = {
  #     owner = "turnserver";
  #   };
  # };
}
