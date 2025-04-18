{ config, ... }:
{
  sops.secrets."silverbullet/environment" = {
    owner = "silverbullet";
  };

  services.silverbullet = {
    enable = true;
    envFile = config.sops.secrets."silverbullet/environment".path;
  };
}
