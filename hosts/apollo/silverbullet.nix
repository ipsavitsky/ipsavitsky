{
  pkgs,
  config,
  ...
}:
{
  sops.secrets = {
    "silverbullet/environment" = {
      owner = "silverbullet";
    };

    "restic/bucket" = {
      owner = "silverbullet";
    };

    "restic/silverbullet" = {
      owner = "silverbullet";
    };
  };

  services.silverbullet = {
    enable = true;
    package = pkgs.silverbullet;
    envFile = config.sops.secrets."silverbullet/environment".path;
  };

  services.restic.backups.silverbullet = {
    user = "silverbullet";
    initialize = true;
    repository = "s3:https://hel1.your-objectstorage.com/bupurinh9s";
    environmentFile = config.sops.secrets."restic/bucket".path;
    passwordFile = config.sops.secrets."restic/silverbullet".path;
    paths = [
      config.services.silverbullet.spaceDir
    ];
  };
}
