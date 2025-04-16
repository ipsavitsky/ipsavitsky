_: {
  services.nginx = {
    virtualHosts."ledger.savitsky.dev" = {
      basicAuth = {
        "ilya" = "changeMeLater";
      };
      locations."/".proxyPass = "http://127.0.0.1:9999";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/hledger-web/ 0700 hledger hledger -"
    "f /var/lib/hledger-web/.hledger.journal 0700 hledger hledger -"
  ];

  networking.firewall.allowedTCPPorts = [ 9999 ];

  services.hledger-web = {
    enable = true;
    port = 9999;
    host = "ledger.savitsky.dev"; # change this later to local dns
    allow = "edit";
  };
}
