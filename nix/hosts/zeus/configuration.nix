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
    users.ilya = {
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
          terminal = "ghostty";
        };
        extraConfig = ''
          # output Unknown-1 mode 3840x2160@60Hz
          output Unknown-1 scale 1.8
        '';
      };

      programs.waybar.enable = true;

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
        # gfxmodeEfi = "1280x720";
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

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "doom";
      };
    };
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
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    bluetooth.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
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
