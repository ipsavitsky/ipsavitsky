{
  pkgs,
  config,
  ...
}:
{
  sops.secrets."silverbullet/environment" = {
    owner = "silverbullet";
  };

  services.silverbullet = {
    enable = true;
    package = pkgs.silverbullet;
    envFile = config.sops.secrets."silverbullet/environment".path;
  };
}
