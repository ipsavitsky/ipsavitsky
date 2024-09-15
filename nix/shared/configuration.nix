{ config, lib, pkgs, ... }: {
  imports = [
    ./packages.nix
  ];
  
  wsl.enable = true;
  wsl.defaultUser = "ilya";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05"; # Match with nixpkgs version
}
