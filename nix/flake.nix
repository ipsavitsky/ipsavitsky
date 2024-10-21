{
  description = "My system configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager.url = "github:nix-community/home-manager";
  };
  outputs = { self, nixpkgs, nixos-wsl, home-manager, emacs-overlay, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./shared/configuration.nix
          nixos-wsl.nixosModules.wsl
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
        ];
      };
      home-pc = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./home-pc/configuration.nix
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ emacs-overlay.overlay ]; }
        ];
      };
    };
  };
}
