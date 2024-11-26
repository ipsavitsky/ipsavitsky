{ ... }:
{
  imports = [ ../../modules/shared.nix ];

  home-manager = {
    users.ilya = {
      imports = [ ../../modules/cli-stack.nix ];
    };
    useGlobalPkgs = true;
  };

  wsl.enable = true;
  wsl.defaultUser = "ilya";
  wsl.wslConf.network.hostname = "hephaestus";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.11";
}
