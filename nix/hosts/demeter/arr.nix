{ ... }:
{
  # sonarr definitions already define a tmpfile
  # https://github.com/NixOS/nixpkgs/blob/nixos-24.11/nixos/modules/services/misc/sonarr.nix
  # systemd.tmpfiles.rules = [
  #   "d /data/sonarr 0700 sonarr sonarr -"
  # ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/data/sonarr";
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/data/radarr";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
}
