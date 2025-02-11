{ config, ... }:
{
  systemd.tmpfiles.rules = [
    "d /data/deluge 0700 deluge deluge -"
  ];

  services.deluge = {
    enable = true;

    dataDir = "/data/deluge";
    openFirewall = true;
    web = {
      enable = true;
      openFirewall = true;
    };
  };
}
