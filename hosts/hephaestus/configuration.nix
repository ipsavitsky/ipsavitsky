{
  inputs,
  ...
}:
{
  imports = [ ../../modules/shared.nix ];

  home-manager = {
    users.ilya = {
      imports = [
        ../../modules/cli-stack.nix
        inputs.sops-nix.homeManagerModules.sops
      ];
      sops.age.keyFile = "/home/ilya/.config/sops/age/keys.txt";

      home.stateVersion = "24.11";
    };
    extraSpecialArgs = {
      inherit inputs;
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

  nix.settings.trusted-users = [ "ilya" ];

  boot = {
    binfmt.emulatedSystems = [
      "aarch64-linux"
    ];
  };

  system.stateVersion = "24.11";
}
