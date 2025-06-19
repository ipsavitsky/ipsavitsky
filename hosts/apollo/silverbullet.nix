{ pkgs, config, ... }:
{
  sops.secrets."silverbullet/environment" = {
    owner = "silverbullet";
  };

  services.silverbullet = {
    enable = true;
    package = pkgs.silverbullet.overrideAttrs (_oldAttrs: rec {
      version = "0.10.4";
      src = pkgs.fetchurl {
        url = "https://github.com/silverbulletmd/silverbullet/releases/download/${version}/silverbullet.js";
        hash = "sha256-ko1zXfvn0rVY+lp9zTZ71BL41h7AOazooBVeqELP3Ps=";
      };
    });
    envFile = config.sops.secrets."silverbullet/environment".path;
  };
  # https://github.com/NixOS/nixpkgs/pull/356163
  systemd.services.silverbullet.serviceConfig = {
    Environment = "DENO_DIR=/var/cache/silverbullet/deno";
    CacheDirectory = "silverbullet";
  };
}
