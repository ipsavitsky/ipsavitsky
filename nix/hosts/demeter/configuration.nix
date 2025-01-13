{
  pkgs,
  ...
}:

{
  time.timeZone = "Europe/London";

  users.users.root.initialPassword = "root";
  users.users.ilya = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGF6pkBKgzxw7EEBJOjCoSoGlcOF3I0yMmHrEmFqXR1R ilya@nixos"
    ];
  };

  networking = {
    hostName = "demeter";
    useDHCP = true;
  };
  raspberry-pi-nix.board = "bcm2712"; # this is raspberry pi 5
  hardware = {
    raspberry-pi = {
      config = {
        all = {
          base-dt-params = {
            BOOT_UART = {
              value = 1;
              enable = true;
            };
            uart_2ndstage = {
              value = 1;
              enable = true;
            };
          };
          dt-overlays = {
            disable-bt = {
              enable = true;
              params = { };
            };
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nmap
  ];

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    fail2ban.enable = true;

    # immich = {
    #   enable = true;
    #   port = 2283;
    # };

    tandoor-recipes = {
      enable = true;
      port = 8888;
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "24.11";
}
