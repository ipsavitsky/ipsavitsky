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
        ./home.nix
        ../../modules/full-stack.nix
        ../../modules/hm/stylix.nix
        ../../modules/hm/sway.nix
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops.age.keyFile = "/home/ilya/.config/sops/age/keys.txt";

      home.stateVersion = "25.05";
    };
    extraSpecialArgs = {
      inherit inputs;
      upper_config = config;
    };
  };

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    binfmt.emulatedSystems = [
      "aarch64-linux"
    ];
  };

  networking = {
    hostName = "hermes";
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
    wrapperFeatures.gtk = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraPackages = [ ];
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "nvidia-x11"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcublas"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "libnpp"
      "nvidia-settings"

      "spotify"
    ];

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
    pcscd.enable = true;
    cpupower-gui.enable = true;
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    xdgOpenUsePortal = false;
    config = {
      preferred = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gnome" ];
      };
    };
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
      sbctl

      nom.packages.${pkgs.system}.default
      statix.packages.${pkgs.system}.default
      deadnix.packages.${pkgs.system}.default
    ];

  nix.settings.trusted-users = [ "ilya" ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
