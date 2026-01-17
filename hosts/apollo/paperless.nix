{ config, ... }:
{
  sops.secrets = {
    "paperless/password" = {
      owner = "paperless";
    };

    "restic/bucket" = {
      # owner = "paperless";
    };

    "restic/paperless" = {
      owner = "paperless";
    };
  };

  systemd.tmpfiles.rules = [
    "d /data/paperless 0700 paperless paperless -"
    "d /data/paperless_export 0700 paperless paperless -"
  ];

  services.paperless = {
    enable = true;
    passwordFile = config.sops.secrets."paperless/password".path;
    domain = "paperless.savitsky.dev";
    dataDir = "/data/paperless";
    database.createLocally = true;
    settings = {
      PAPERLESS_ADMIN_USER = "ilya";
      PAPERLESS_OCR_LANGUAGE = "rus+eng";
    };
  };

  services.restic.backups.paperless = {
    user = "paperless";
    backupPrepareCommand = ''
      ${config.services.paperless.manage}/bin/paperless-manage document_exporter /data/paperless_export
    '';
    initialize = true;
    repository = "s3:https://hel1.your-objectstorage.com/bupurinh9s/paperless";
    environmentFile = config.sops.secrets."restic/bucket".path;
    passwordFile = config.sops.secrets."restic/paperless".path;
    paths = [
      "/data/paperless_export"
    ];
  };
}
