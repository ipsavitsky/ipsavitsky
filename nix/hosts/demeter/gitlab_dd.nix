{
  pkgs,
  gitlab_due_date,
  config,
  ...
}:
{
  systemd.timers."gitlab_due_date" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "3d";
      OnUnitActiveSec = "3d";
      Unit = "gitlab_due_date.service";
    };
  };

  systemd.services."gitlab_due_date" = {
    script = ''
      ${gitlab_due_date.packages.${pkgs.system}.default}/bin/gitlab_due_date ${
        config.sops.secrets."gitlab_dd/config.json".path
      }
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "gitlab_dd";
    };
  };

  sops.secrets."gitlab_dd/config.json" = {
    owner = "gitlab_dd";
  };

  users.users.gitlab_dd = {
    isSystemUser = true;
    group = "gitlab_dd";
  };

  users.groups.gitlab_dd = { };
}
