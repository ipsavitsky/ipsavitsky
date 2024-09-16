{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-wsl, home-manager, emacs-overlay, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./shared/configuration.nix
        nixos-wsl.nixosModules.wsl
        home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
      ];
    };
  };
}
