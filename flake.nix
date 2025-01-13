{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mods-home-manager = {
      url = "github:ipsavitsky/mods-home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty.url = "github:ghostty-org/ghostty";
    zed.url = "github:zed-industries/zed";
    caligula.url = "github:ifd3f/caligula";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    raspberry-pi.url = "github:nix-community/raspberry-pi-nix";
    nil.url = "github:oxalica/nil";
    cachix.url = "github:cachix/cachix";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      nixos-wsl,
      home-manager,
      emacs-overlay,
      zen-browser,
      mods-home-manager,
      ghostty,
      raspberry-pi,
      zed,
      caligula,
      nil,
      cachix,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # formatter.${system} = pkgs.nixfmt-rfc-style;
      formatter.${system} = (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper;

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nil.packages."${pkgs.system}".default
            terraform-ls
            (terraform.withPlugins (p: [ p.github ]))
            caligula.packages."${pkgs.system}".default
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
            inherit ghostty;
            inherit zen-browser;
            inherit zed;
            inherit cachix;
            inherit home-manager;
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

  nixConfig = {
    extra-substituters = [
      "https://ghostty.cachix.org"
      "https://nix-community.cachix.org"
      "https://cachix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    ];
  };
}
