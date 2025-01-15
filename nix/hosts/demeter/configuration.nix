{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./gitlab_dd.nix
  ];

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

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "24.11";
}
