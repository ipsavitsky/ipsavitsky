{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nixpkgs-stable, nixos-wsl, home-manager, ... }@inputs:

    let system = "x86_64-linux";
    in {

      nixosConfigurations.old-personal = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./old-personal/configuration.nix
	  ./shared/packages.nix
        ];
      };

      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
	  ./wsl/configuration.nix
	  ./shared/packages.nix
	  nixos-wsl.nixosModules.wsl
	];
      };

      homeConfigurations.ilya = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/home.nix ];
      };
    };
}
