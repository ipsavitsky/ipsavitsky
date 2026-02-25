{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayland-overlay = {
      url = "github:nix-community/nixpkgs-wayland";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
    ntfyer = {
      url = "github:ipsavitsky/ntfyer";
      inputs.flake-utils.follows = "flake-utils";
    };
    # pinned because https://github.com/Alexays/Waybar/issues/4802
    waybar.url = "github:Alexays/waybar";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    sb_mcp.url = "github:ipsavitsky/sb_mcp";
    lanzaboote.url = "github:nix-community/lanzaboote";
    zemon.url = "github:sunng87/zemon";
    mergiraf.url = "git+https://codeberg.org/mergiraf/mergiraf.git?ref=main";
    terminaltrove = {
      url = "github:ipsavitsky/terminaltrove-flake";
      inputs.flake-utils.follows = "flake-utils";
    };
    nix-ai-tools = {
      url = "github:numtide/llm-agents.nix";
      inputs.treefmt-nix.follows = "treefmt-nix";
    };
    wiremix.url = "github:tsowell/wiremix";
    wifitui = {
      url = "github:shazow/wifitui";
      inputs.flake-utils.follows = "flake-utils";
    };
    try.url = "github:tobi/try";
    deploy-rs.url = "github:serokell/deploy-rs";
    interlinked.url = "github:ipsavitsky/interlinked";
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      treefmt-nix,
      home-manager,
      sops-nix,
      srvos,
      nixos-hardware,
      lanzaboote,
      nur,
      deploy-rs,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

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
                ssh-to-age
                age
                sops
                just
                nil
                pkgs.deploy-rs
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
            nur.modules.nixos.default
            # this a p14s gen4 but gen 3 is close enough
            # nixos-hardware.nixosModules.lenovo-thinkpad-p14s-intel-gen3
          ];
        };

        # hephaestus = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs;
        #   };
        #   system = "x86_64-linux";
        #   modules = [
        #     ./hosts/hephaestus/configuration.nix
        #     nixos-wsl.nixosModules.wsl
        #     home-manager.nixosModules.home-manager
        #     nur.modules.nixos.default
        #   ];
        # };

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
            nur.modules.nixos.default
          ];
        };

        # demeter = nixpkgs.lib.nixosSystem {
        #   system = "aarch64-linux";
        #   specialArgs = {
        #     inherit inputs;
        #   };
        #   modules = [
        #     raspberry-pi.nixosModules.raspberry-pi
        #     raspberry-pi.nixosModules.sd-image
        #     sops-nix.nixosModules.sops
        #     srvos.nixosModules.server
        #     srvos.nixosModules.mixins-nginx
        #     srvos.nixosModules.mixins-terminfo
        #     srvos.nixosModules.mixins-nix-experimental
        #     nixos-hardware.nixosModules.raspberry-pi-5
        #     nur.modules.nixos.default
        #     ./hosts/demeter/configuration.nix
        #   ];
        # };

        apollo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            sops-nix.nixosModules.sops
            srvos.nixosModules.server
            srvos.nixosModules.mixins-terminfo
            srvos.nixosModules.mixins-nix-experimental
            nur.modules.nixos.default
            ./hosts/apollo/configuration.nix
          ];
        };

        helios = nixpkgs.lib.nixosSystem {
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
            ./hosts/helios/configuration.nix
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
    }
    // (import ./deploy.nix { inherit self deploy-rs; });

  nixConfig = {
    extra-substituters = [
      "https://ghostty.cachix.org"
      "https://nix-community.cachix.org"
      "https://cachix.cachix.org"
      "https://helix.cachix.org"
      "https://gitu.cachix.org"
      "https://zed.cachix.org"
      "https://cache.numtide.com"
    ];
    extra-trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "gitu.cachix.org-1:iUIaNys1l3W1LF/M8OXzaTl7N/OinGOlzdUJUSc+5eY="
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };
}
