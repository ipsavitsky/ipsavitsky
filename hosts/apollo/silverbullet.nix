{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  sops.secrets = {
    "silverbullet/environment" = {
      owner = "silverbullet";
    };

    "restic/bucket" = {
      # owner = "silverbullet";
    };

    "restic/silverbullet" = {
      owner = "silverbullet";
    };
  };

  services.silverbullet =
    let
      pkgs_unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
    in
    {
      enable = true;
      package = pkgs_unstable.silverbullet;
      envFile = config.sops.secrets."silverbullet/environment".path;
    };

  systemd.services.silverbullet = {
    path = [ pkgs.chromium ];
    environment.SB_CHROME_PATH = lib.getExe pkgs.chromium;
  };

  services.restic.backups.silverbullet = {
    user = "silverbullet";
    initialize = true;
    repository = "s3:https://hel1.your-objectstorage.com/bupurinh9s/silverbullet";
    environmentFile = config.sops.secrets."restic/bucket".path;
    passwordFile = config.sops.secrets."restic/silverbullet".path;
    paths = [
      config.services.silverbullet.spaceDir
    ];
  };

  systemd.services.silverbullet-rumdl-fmt = {
    description = "Run rumdl fmt on the SilverBullet space directory";
    serviceConfig = {
      Type = "oneshot";
      User = config.services.silverbullet.user;
      Group = config.services.silverbullet.group;
      ExecStart = "${lib.getExe pkgs.rumdl} fmt ${config.services.silverbullet.spaceDir}";
    };
  };

  systemd.timers.silverbullet-rumdl-fmt = {
    description = "Daily rumdl fmt for SilverBullet space";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
