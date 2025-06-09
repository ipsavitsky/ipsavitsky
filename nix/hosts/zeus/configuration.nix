{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/shared.nix

    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  home-manager = {
    users.ilya =
      let
        hm-cfg = config.home-manager.users.ilya;
      in
      {
        imports = [
          ../../modules/full-stack.nix
          ../../modules/stylix.nix
          inputs.sops-nix.homeManagerModules.sops
        ];

        wayland.windowManager.sway = {
          enable = true;
          package = null;
          wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
          config = {
            modifier = "Mod4";
            menu = (pkgs.lib.getExe hm-cfg.programs.fuzzel.package);
            terminal = "ghostty";
            output = {
              "*" = {
                scale = "2";
              };
            };
            bars = [ { command = (pkgs.lib.getExe hm-cfg.programs.waybar.package); } ];
            keybindings = pkgs.lib.mkOptionDefault {
              "Mod4+l" = "exec ${pkgs.lib.getExe hm-cfg.programs.swaylock.package} -d --clock --indicator";
            };
          };
        };

        programs = {
          waybar = {
            enable = true;
            package = inputs.waybar.packages."x86_64-linux".default;
          };
          fuzzel.enable = true;
          swaylock = {
            enable = true;
            package = inputs.wayland-overlay.packages."x86_64-linux".swaylock-effects;
          };
        };

        services = {
          mako = {
            enable = true;
            package = inputs.wayland-overlay.packages."x86_64-linux".mako;
            settings = {
              actions = true;
              icons = true;
              ignore-timout = false;
              default-timeout = 10;
              markup = true;
            };
          };
          swayidle = {
            package = inputs.wayland-overlay.packages."x86_64-linux".swayidle;
            enable = true;
            extraArgs = [ "-d" ];
            timeouts =
              let
                swaylock-pkg = pkgs.lib.getExe hm-cfg.programs.swaylock.package;
                swaymsg-pkg = pkgs.lib.getExe' config.programs.sway.package "swaymsg";
                lock-timout = 5 * 60;
              in
              [
                {
                  timeout = lock-timout;
                  command = "${swaylock-pkg} -d --clock --indicator";
                }
                {
                  timeout = lock-timout + 20;
                  command = "${swaymsg-pkg} 'output * dpms off'";
                  resumeCommand = "${swaymsg-pkg} 'output * dpms on'";
                }
              ];
          };
        };

        sops.age.keyFile = "/home/ilya/.config/sops/age/keys.txt";

        home.stateVersion = "24.11";
      };
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        gfxmodeEfi = "1280x720";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    binfmt.emulatedSystems = [
      "aarch64-linux"
    ];
  };

  networking = {
    hostName = "zeus";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  programs.sway = {
    enable = true;
    # package = inputs.swayfx.packages.${pkgs.system}.default;
    package = pkgs.swayfx;
    extraOptions = [
      "--unsupported-gpu"
    ];
  };

  services = {
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver.videoDrivers = [ "nvidia" ];
    displayManager.ly.enable = true;
    blueman.enable = true;
    ollama = {
      acceleration = "cuda";
    };
    flatpak = {
      enable = true;
      packages = [
        "app.zen_browser.zen"
      ];
    };
    printing.enable = true;
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    bluetooth.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "uucp"
    ];
  };

  environment.systemPackages =
    with pkgs;
    with inputs;
    [
      blueman
      telegram-desktop
      spotify
      gparted
      nmap
      transmission_4-qt
      mani
      nvtopPackages.nvidia

      nom.packages.${pkgs.system}.default
      statix.packages.${pkgs.system}.default
      deadnix.packages.${pkgs.system}.default
    ];

  nix.settings.trusted-users = [ "ilya" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
