{ mods-hm, ... }:
{
  imports = [ ../../modules/shared.nix ];

  home-manager = {
    users.ilya = {
      imports = [
        ../../modules/cli-stack.nix
      ];
    };

    extraSpecialArgs = {
      inherit mods-hm;
    };

    useGlobalPkgs = true;
  };

  wsl.enable = true;
  wsl.defaultUser = "ilya";
  wsl.wslConf.network.hostname = "hephaestus";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "ilya" ];
  };

  system.stateVersion = "24.11";
}
