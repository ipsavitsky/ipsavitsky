{
  mods-hm,
  helix,
  charmbracelet-nur,
  nix-index-database,
  gitu,
  stylix,
  yazi,
  script-pile,
  nix-tree,
  nix-melt,
  ...
}:
{
  imports = [ ../../modules/shared.nix ];

  home-manager = {
    users.ilya = {
      imports = [
        ../../modules/cli-stack.nix
      ];
      home.stateVersion = "24.11";
    };
    extraSpecialArgs = {
      inherit mods-hm;
      inherit helix;
      inherit charmbracelet-nur;
      inherit nix-index-database;
      inherit gitu;
      inherit stylix;
      inherit yazi;
      inherit script-pile;
      inherit nix-tree;
      inherit nix-melt;
    };
    useGlobalPkgs = true;
  };

  wsl = {
    enable = true;
    defaultUser = "ilya";
    wslConf.network = {
      hostname = "hephaestus";
      generateResolvConf = true;
    };
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
