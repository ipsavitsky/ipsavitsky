{ ... }:
{
  systemd.tmpfiles.rules = [
    "d /data/jellyfin 0700 jellyfin jellyfin -"
    "d /data/jellyfin-cache 0700 jellyfin jellyfin -"
  ];

  services.jellyfin = {
    enable = true;

    dataDir = "/data/jellyfin";
    cacheDir = "/data/jellyfin-cache";
    openFirewall = true;
  };
}
