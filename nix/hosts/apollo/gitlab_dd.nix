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

  sops.secrets."gitlab_dd/config.json" = {
    owner = "gitlab_dd";
  };
}
