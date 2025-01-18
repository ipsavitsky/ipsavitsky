{ ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
  ];

  services = {
    jitsi-meet = {
      enable = true;
      hostName = "meet.savitsky.dev";
      prosody.lockdown = true;
      config = {
        enableWelcomePage = false;
        prejoinPageEnabled = true;
        # defaultLang = "fi";
      };
      interfaceConfig = {
        SHOW_JITSI_WATERMARK = false;
        SHOW_WATERMARK_FOR_GUESTS = false;
      };
    };
    jitsi-videobridge.openFirewall = true;
    nginx.enable = true;
  };

  # services.nginx.virtualHosts."meet.savitsky.dev" = {
  #   enableACME = true;
  #   forceSSL = true;
  #   basicAuthFile = "/var/lib/jitsi-auth";
  # };

  security.acme.email = "ipsavitsky234@gmail.com";
  security.acme.acceptTerms = true;
}
