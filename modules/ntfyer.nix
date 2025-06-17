{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.ntfyer.homeManagerModules.ntfyer
  ];

  services.ntfyer = {
    enable = true;
    configurationFile = config.sops.secrets."ntfyer/config.zon".path;
  };

  sops.secrets."ntfyer/config.zon" = {
    sopsFile = ../secrets/hm.yaml;
  };
}
