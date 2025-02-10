{ ... }:
{
  systemd.tmpfiles.rules = [
    "d /data/jellyfin 0700 jellyfin jellyfin -"
  ];

  services.jellyfin = {
    enable = true;

    dataDir = "/data/jellyfin";
    openFirewall = true;
  };
}
