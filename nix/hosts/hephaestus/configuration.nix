{
  mods-hm,
  helix,
  charmbracelet-nur,
  ...
}:
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
      inherit helix;
      inherit charmbracelet-nur;
    };
    useGlobalPkgs = true;
  };

  wsl = {
    enable = true;
    defaultUser = "ilya";
    wslConf.network.hostname = "hephaestus";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "ilya" ];
  };

  boot = {
    binfmt.emulatedSystems = [
      "aarch64-linux"
    ];
  };

  system.stateVersion = "24.11";
}
