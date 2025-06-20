{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    charmbracelet-nur = {
      url = "github:charmbracelet/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayland-overlay = {
      url = "github:nix-community/nixpkgs-wayland";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.flake-utils.follows = "flake-utils";
    };
    zed.url = "github:zed-industries/zed";
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
    nil.url = "github:oxalica/nil";
    gitu.url = "github:altsem/gitu";
    gitlab_due_date = {
      url = "github:ipsavitsky/gitlab_due_dates";
      inputs.flake-utils.follows = "flake-utils";
    };
    helix.url = "github:helix-editor/helix";
    savitsky-dev = {
      url = "github:ipsavitsky/savitsky.dev";
      inputs.flake-utils.follows = "flake-utils";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.flake-utils.follows = "flake-utils";
    };
    script-pile = {
      url = "github:ipsavitsky/script_pile";
      inputs.flake-utils.follows = "flake-utils";
    };
    ploc = {
      url = "github:ipsavitsky/ploc";
      inputs.flake-utils.follows = "flake-utils";
    };
    nothingverse = {
      url = "github:ipsavitsky/nothingverse";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-tree = {
      url = "github:utdemir/nix-tree";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-melt.url = "github:nix-community/nix-melt";
    pomidor.url = "github:ipsavitsky/pomidor";
    raspberry-pi.url = "github:nix-community/raspberry-pi-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    ntfyer = {
      url = "github:ipsavitsky/ntfyer";
      inputs.flake-utils.follows = "flake-utils";
    };
    waybar.url = "github:Alexays/waybar";
    swayfx.url = "github:WillPower3309/swayfx";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    sb_mcp.url = "github:ipsavitsky/sb_mcp";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
      nixos-wsl,
      home-manager,
      sops-nix,
      raspberry-pi,
      srvos,
      nixos-hardware,
      lanzaboote,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        treefmtModule = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      {
        formatter = treefmtModule.config.build.wrapper;

        checks = {
          formatting = treefmtModule.config.build.check self;
        };

        devShells = {
          default = pkgs.mkShell {
            packages =
              with pkgs;
              with inputs;
              [
                terraform-ls
                (terraform.withPlugins (p: [ p.github ]))
                ssh-to-age
                age
                sops
                just

                caligula.packages.${pkgs.system}.default
                nil.packages.${pkgs.system}.default
                vulnix.packages.${pkgs.system}.default
                deadnix.packages.${pkgs.system}.default
                statix.packages.${pkgs.system}.default
                nom.packages.${pkgs.system}.default
                nvd.packages.${pkgs.system}.nvd
                home-manager.packages.${pkgs.system}.home-manager
              ];
          };
        };
      }
    )
    // {
      nixosConfigurations = {
        hermes = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./hosts/hermes/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            srvos.nixosModules.desktop
            srvos.nixosModules.mixins-nix-experimental
            {
              nixpkgs = {
                # cuda modules are unfree
                config.allowUnfree = true;
              };
            }
          ];
        };

        hephaestus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./hosts/hephaestus/configuration.nix
            nixos-wsl.nixosModules.wsl
            home-manager.nixosModules.home-manager
          ];
        };

        zeus = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./hosts/zeus/configuration.nix
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            srvos.nixosModules.desktop
            srvos.nixosModules.mixins-nix-experimental
            {
              nixpkgs = {
                # cuda modules are unfree
                config.allowUnfree = true;
              };
            }
          ];
        };

        demeter = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            raspberry-pi.nixosModules.raspberry-pi
            raspberry-pi.nixosModules.sd-image
            sops-nix.nixosModules.sops
            srvos.nixosModules.server
            srvos.nixosModules.mixins-nginx
            srvos.nixosModules.mixins-terminfo
            srvos.nixosModules.mixins-nix-experimental
            nixos-hardware.nixosModules.raspberry-pi-5
            ./hosts/demeter/configuration.nix
          ];
        };

        apollo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            sops-nix.nixosModules.sops
            srvos.nixosModules.server
            srvos.nixosModules.mixins-nginx
            srvos.nixosModules.mixins-terminfo
            srvos.nixosModules.mixins-nix-experimental
            ./hosts/apollo/configuration.nix
          ];
        };

        # cronos = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs;
        #   };
        #   system = "x86_64-linux";
        #   modules = [
        #     ./nix/hosts/cronos/configuration.nix
        #     home-manager.nixosModules.home-manager
        #     srvos.nixosModules.desktop
        #     srvos.nixosModules.mixins-nix-experimental
        #     {
        #       nixpkgs = {
        #         overlays = [ emacs-overlay.overlay ];
        #         # cuda modules are unfree
        #         config.allowUnfree = true;
        #       };
        #     }
        #   ];
        # };
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://ghostty.cachix.org"
      "https://nix-community.cachix.org"
      "https://cachix.cachix.org"
      "https://helix.cachix.org"
      "https://gitu.cachix.org"
      "https://zed.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "gitu.cachix.org-1:iUIaNys1l3W1LF/M8OXzaTl7N/OinGOlzdUJUSc+5eY="
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
    ];
  };
}
