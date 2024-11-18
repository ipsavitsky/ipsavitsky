{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../../shared/packages.nix ];

  wsl.enable = true;
  wsl.defaultUser = "ilya";
  wsl.wslConf.network.hostname = "hephaestus";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.11";
}
