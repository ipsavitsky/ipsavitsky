_: {
  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8792"
  ];

  services = {
    jitsi-meet = {
      enable = true;
      hostName = "meet.savitsky.dev";
      prosody.lockdown = true;
    };

    jitsi-videobridge.openFirewall = true;
  };
}
