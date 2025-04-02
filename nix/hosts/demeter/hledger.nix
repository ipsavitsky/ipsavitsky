_: {
  systemd.tmpfiles.rules = [
    "d /data/hledger 0700 hledger hledger -"
    "f /data/hledger/.hledger.journal 0700 hledger hledger -"
  ];

  networking.firewall.allowedTCPPorts = [ 9999 ];

  services.hledger-web = {
    enable = true;
    port = 9999;
    stateDir = "/data/hledger";
    host = "192.168.55.102"; # change this later to local dns
    allow = "edit";
  };
}
