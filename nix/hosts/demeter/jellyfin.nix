{ ... }:
{
  systemd.tmpfiles.rules = [
    "d /data/jellyfin 0700 jellyfin jellyfin -"
  ];

  services.jellyfin = {
    enable = false;

    dataDir = "/data/jellyfin";
    openFirewall = true;
  };
}
