{ inputs, config, ... }:
{
  imports = [
    inputs.interlinked.nixosModules.interlinked
  ];

  sops.secrets = {
    "restic/bucket" = { };

    "restic/interlinked" = {
      owner = "interlinked";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/interlinked/ 0700 interlinked interlinked -"
  ];

  services.interlinked = {
    enable = true;
    address = "localhost:4567";
    dataDir = "/var/lib/interlinked";
    url = "https://itlkd.savitsky.dev";
  };

  services.restic.backups.interlinked = {
    user = "interlinked";
    initialize = true;
    repository = "s3:https://hel1.your-objectstorage.com/bupurinh9s/interlinked";
    environmentFile = config.sops.secrets."restic/bucket".path;
    passwordFile = config.sops.secrets."restic/interlinked".path;
    paths = [
      config.services.interlinked.dataDir
    ];
  };
}
