{
  description = "My system configuration";
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
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      emacs-overlay,
      zen-browser,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        hephaestus = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/hephaestus/configuration.nix
            nixos-wsl.nixosModules.wsl
            home-manager.nixosModules.home-manager
            { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
          ];
        };
        zeus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          inherit system;
          modules = [
            ./hosts/zeus/configuration.nix
            home-manager.nixosModules.home-manager
            { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
          ];
        };
      };
    };
}
