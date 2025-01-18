{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./gitlab_dd.nix
    # ./ddclient.nix
    ./tandoor.nix
    ./postgres.nix
    # ./jitsi.nix
  ];

  time.timeZone = "Europe/London";

  networking = {
    hostName = "demeter";
    useDHCP = true;
    firewall.allowedTCPPorts = [
      22
      80
      443
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
    btrfs-progs
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

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      # virtualHosts."savitsky.dev" = {
      #   default = true;
      #   # what is this acme challenge...
      # locations."./well-known" = {
      #   proxyPass = "http://localhost:80";
      # };
      # };
    };
  };

  sops = {
    defaultSopsFile = ../../../secrets/demeter.yaml;
    age.keyFile = "/home/ilya/.config/sops/age/keys.txt";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "24.11";
}
