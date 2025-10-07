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
  ];

  home-manager = {
    users.ilya = {
      imports = [
        ../../modules/full-stack.nix
        ../../modules/hm/stylix.nix
        ../../modules/hm/sway.nix
        inputs.sops-nix.homeManagerModules.sops
      ];

      wayland.windowManager.sway.config.output."*".scale = "2";

      sops.age.keyFile = "/home/ilya/.config/sops/age/keys.txt";

      home.stateVersion = "24.11";
    };
    extraSpecialArgs = {
      inherit inputs;
      upper_config = config;
    };
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
    package = pkgs.sway;
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraPackages = [ ];
  };

  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
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
    flatpak.enable = true;
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
