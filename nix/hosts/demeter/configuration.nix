{
  pkgs,
  gitlab_due_date,
  ...
}:

{
  time.timeZone = "Europe/London";

  networking = {
    hostName = "demeter";
    useDHCP = true;
    firewall.allowedTCPPorts = [
      22
      80
    ];
  };

  users.users = {
    root.initialPassword = "root";
    ilya = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGF6pkBKgzxw7EEBJOjCoSoGlcOF3I0yMmHrEmFqXR1R ilya@nixos"
      ];
      extraGroups = [ "wheel" ];
    };
  };

  raspberry-pi-nix.board = "bcm2712"; # this is raspberry pi 5

  hardware = {
    raspberry-pi = {
      config = {
        all = {
          options = {
            camera_auto_detect = {
              enable = true;
              value = 0;
            };
            display_auto_detect = {
              enable = true;
              value = 0;
            };
          };
          base-dt-params = {
            pciex3 = {
              enable = true;
            };
            pciex1_gen = {
              enable = true;
              value = 3;
            };
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neofetch
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

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts."_" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
          }
        ];
        locations."/" = {
          proxyPass = "http://127.0.0.1:8888";
        };
      };
    };
  };

  # systemd.timers."gitlab_due_date" = {
  #   wantedBy = ["timers.target"];
  #   timerConfig = {
  #     OnBootSec = "5m";
  #     OnUnitActiveSec = "5m";
  #     Unit = "gitlab_due_date.service";
  #   };
  # };

  # systemd.services."gitlab_due_date" = {
  #   script = "${gitlab_due_date.packages.${pkgs.system}.default}/bin/gitlab_due_date";
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #   };
  # };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "24.11";
}
