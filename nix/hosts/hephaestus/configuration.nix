{
  mods-hm,
  helix,
  charmbracelet-nur,
  nix-index-database,
  gitu,
  ...
}:
{
  imports = [ ../../modules/shared.nix ];

  home-manager = {
    users.ilya = {
      imports = [
        ../../modules/cli-stack.nix
        nix-index-database.hmModules.nix-index
      ];
      home.stateVersion = "24.11";
    };
    extraSpecialArgs = {
      inherit mods-hm;
      inherit helix;
      inherit charmbracelet-nur;
      inherit nix-index-database;
      inherit gitu;
    };
    useGlobalPkgs = true;
  };

  wsl = {
    enable = true;
    defaultUser = "ilya";
    wslConf.network.hostname = "hephaestus";
    interop.register = true;
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
