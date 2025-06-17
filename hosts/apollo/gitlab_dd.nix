{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.gitlab_due_date.nixosModules.gitlab_dd
  ];

  services.gitlab_dd = {
    enable = true;
    config_path = config.sops.secrets."gitlab_dd/config.json".path;
    package = inputs.gitlab_due_date.packages.${pkgs.system}.default;
  };

  systemd.timers."gitlab_due_date".timerConfig.OnCalendar = pkgs.lib.mkForce "Wed *-*-* 00:10:00";

  sops.secrets."gitlab_dd/config.json" = {
    owner = "gitlab_dd";
  };
}
