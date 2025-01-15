{
  pkgs,
  gitlab_due_date,
  ...
}:
let
  gitlab_dd_config_file = builtins.toFile "gitlab_dd_config_file" (
    builtins.toJSON {
      base_url = "gitlab.codethink.co.uk/api/v4";
    }
  );
in
{
  systemd.timers."gitlab_due_date" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "gitlab_due_date.service";
    };
  };

  systemd.services."gitlab_due_date" = {
    script = "${
      gitlab_due_date.packages.${pkgs.system}.default
    }/bin/gitlab_due_date ${gitlab_dd_config_file}";

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    environment = {
      GITLAB_DD_TOKEN = "";
    };
  };
}
