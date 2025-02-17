{
  pkgs,
  gitlab_due_date,
  config,
  ...
}:
{
  imports = [
    gitlab_due_date.nixosModules.gitlab_dd
  ];

  services.gitlab_dd = {
    enable = true;
    config_path = config.sops.secrets."gitlab_dd/config.json".path;
    package = gitlab_due_date.packages.${pkgs.system}.default;
  };

  sops.secrets."gitlab_dd/config.json" = {
    owner = "gitlab_dd";
  };
}
