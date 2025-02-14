{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    charmbracelet-nur = {
      url = "github:charmbracelet/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mods-home-manager = {
      url = "github:ipsavitsky/mods-home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty.url = "github:ghostty-org/ghostty";
    # not using the original repo because of https://github.com/zed-industries/zed/issues/22098
    zed.url = "github:danielgafni/zed";
    caligula.url = "github:ifd3f/caligula";
    nil.url = "github:oxalica/nil";
    cachix.url = "github:cachix/cachix";
    gitlab_due_date.url = "github:ipsavitsky/gitlab_due_dates";
    helix.url = "github:helix-editor/helix";
    savitsky-dev.url = "github:ipsavitsky/savitsky.dev";
    secret.url = "git+ssh://git@github.com/ipsavitsky/secret?ref=main";

    raspberry-pi.url = "github:nix-community/raspberry-pi-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs =
    {
      self,
      nixpkgs,
      charmbracelet-nur,
      treefmt-nix,
      nixos-wsl,
      home-manager,
      sops-nix,
      emacs-overlay,
      zen-browser,
      mods-home-manager,
      ghostty,
      raspberry-pi,
      zed,
      caligula,
      nil,
      cachix,
      gitlab_due_date,
      helix,
      savitsky-dev,
      secret,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter.${system} = (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper;

      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nil.packages."${pkgs.system}".default
            terraform-ls
            (terraform.withPlugins (p: [ p.github ]))
            caligula.packages."${pkgs.system}".default
            ssh-to-age
            age
            sops
          ];
        };
      };

      nixosConfigurations = {
        hephaestus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            mods-hm = mods-home-manager;
            inherit helix;
            inherit charmbracelet-nur;
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
            inherit helix;
            inherit charmbracelet-nur;
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
          specialArgs = {
            inherit gitlab_due_date;
            inherit savitsky-dev;
            inherit secret;
          };
          modules = [
            raspberry-pi.nixosModules.raspberry-pi
            raspberry-pi.nixosModules.sd-image
            sops-nix.nixosModules.sops
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
      "https://helix.cachix.org"
      "https://danielgafni.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "danielgafni.cachix.org-1:ZdXJoJEqeiGGOf/MtAiocqj7/vvFbA2MWFVwopJ2WQM="
    ];
  };
}
