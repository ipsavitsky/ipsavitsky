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
    ../../modules/desktop.nix
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
        efiInstallAsRemovable = true;
      };
      efi = {
        # canTouchEfiVariables = true;
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

  users.users.ilya = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "uucp"
    ];
  };

  nix.settings.trusted-users = [ "ilya" ];

  environment.systemPackages = with pkgs; [ nvtopPackages.nvidia ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
