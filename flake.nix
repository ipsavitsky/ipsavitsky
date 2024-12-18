{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mods-home-manager = {
      url = "github:ipsavitsky/mods-home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    raspberry-pi = {
      url = "github:nix-community/raspberry-pi-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      emacs-overlay,
      zen-browser,
      mods-home-manager,
      raspberry-pi,
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            terraform-ls
            terraform
          ];
        };
      };

      nixosConfigurations = {
        hephaestus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            mods-hm = mods-home-manager;
          };
          inherit system;
          modules = [
            ./nix/hosts/hephaestus/configuration.nix
            nixos-wsl.nixosModules.wsl
            home-manager.nixosModules.home-manager
            { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
          ];
        };
        zeus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            mods-hm = mods-home-manager;
          };
          inherit system;
          modules = [
            ./nix/hosts/zeus/configuration.nix
            home-manager.nixosModules.home-manager
            { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
          ];
        };
        demeter = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            raspberry-pi.nixosModules.raspberry-pi
            raspberry-pi.nixosModules.sd-image
            ./nix/hosts/demeter/configuration.nix
          ];
        };
      };
    };
}
