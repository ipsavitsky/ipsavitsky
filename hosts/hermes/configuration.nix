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
        ./home.nix
        ../../modules/full-stack.nix
        ../../modules/hm/stylix.nix
        ../../modules/hm/sway.nix
        inputs.sops-nix.homeManagerModules.sops
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
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
    # package = inputs.swayfx.packages.${pkgs.system}.default;
    package = pkgs.swayfx;
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraPackages = [ ];
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
        enable = true;
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
      sbctl

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
  system.stateVersion = "25.05"; # Did you read the comment?
}
