_: {
  systemd.tmpfiles.rules = [
    "d /var/lib/hledger-web/ 0700 hledger hledger -"
    "f /var/lib/hledger-web/.hledger.journal 0700 hledger hledger -"
  ];

  networking.firewall.allowedTCPPorts = [ 9999 ];

  services.hledger-web = {
    enable = true;
    port = 9999;
    host = "192.168.55.108"; # change this later to local dns
    allow = "edit";
  };
}
