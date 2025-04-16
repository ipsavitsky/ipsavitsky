_: {
  # services.nginx = {
  #   virtualHosts."192.168.55.108" = {
  #     basicAuth = {
  #       "ilya" = "changeMeLater";
  #     };
  #     locations."/".proxyPass = "http://127.0.0.1:9998";
  #     listen = [
  #       {
  #         addr = "0.0.0.0";
  #         port = 9999;
  #       }
  #     ];
  #   };
  # };

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
