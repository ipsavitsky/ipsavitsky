{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
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
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.flake-utils.follows = "flake-utils";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.flake-utils.follows = "flake-utils";
    };
    # not using the original repo because of https://github.com/zed-industries/zed/issues/22098
    zed.url = "github:danielgafni/zed";
    vulnix.url = "github:nix-community/vulnix";
    deadnix = {
      url = "github:astro/deadnix";
      inputs.utils.follows = "flake-utils";
    };
    statix.url = "github:oppiliappan/statix";
    nom = {
      url = "github:maralorn/nix-output-monitor";
      inputs.flake-utils.follows = "flake-utils";
    };
    nvd = {
      url = "git+https://git.sr.ht/~khumba/nvd";
      inputs.flake-utils.follows = "flake-utils";
    };
    caligula = {
      url = "github:ifd3f/caligula";
      inputs.flake-utils.follows = "flake-utils";
    };
    nil = {
      url = "github:oxalica/nil";
      inputs.flake-utils.follows = "flake-utils";
    };
    gitu.url = "github:altsem/gitu";
    gitlab_due_date = {
      url = "github:ipsavitsky/gitlab_due_dates";
      inputs.flake-utils.follows = "flake-utils";
    };
    helix = {
      url = "github:helix-editor/helix";
      inputs.flake-utils.follows = "flake-utils";
    };
    savitsky-dev = {
      url = "github:ipsavitsky/savitsky.dev";
      inputs.flake-utils.follows = "flake-utils";
    };

    raspberry-pi.url = "github:nix-community/raspberry-pi-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
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
      vulnix,
      deadnix,
      statix,
      nom,
      nvd,
      nil,
      gitu,
      gitlab_due_date,
      helix,
      savitsky-dev,
      nix-minecraft,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        formatter = (treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper;

        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nil.packages."${pkgs.system}".default
              terraform-ls
              (terraform.withPlugins (p: [ p.github ]))
              caligula.packages."${pkgs.system}".default
              vulnix.packages."${pkgs.system}".default
              deadnix.packages."${pkgs.system}".default
              statix.packages."${pkgs.system}".default
              nom.packages."${pkgs.system}".default
              nvd.packages."${pkgs.system}".nvd
              ssh-to-age
              age
              sops
              just
            ];
          };
        };
      }
    )
    // {
      nixosConfigurations = {
        hephaestus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            mods-hm = mods-home-manager;
            inherit helix;
            inherit gitu;
            inherit charmbracelet-nur;
          };
          system = "x86_64-linux";
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
            inherit home-manager;
            inherit helix;
            inherit gitu;
            inherit charmbracelet-nur;
            inherit nom;
            inherit statix;
            inherit deadnix;
            mods-hm = mods-home-manager;
          };
          system = "x86_64-linux";
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
            inherit nix-minecraft;
            inherit charmbracelet-nur;
          };
          modules = [
            raspberry-pi.nixosModules.raspberry-pi
            raspberry-pi.nixosModules.sd-image
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
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
      "https://gitu.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "danielgafni.cachix.org-1:ZdXJoJEqeiGGOf/MtAiocqj7/vvFbA2MWFVwopJ2WQM="
      "gitu.cachix.org-1:iUIaNys1l3W1LF/M8OXzaTl7N/OinGOlzdUJUSc+5eY="
    ];
  };
}
