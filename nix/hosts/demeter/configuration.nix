{
  pkgs,
  charmbracelet-nur,
  home-manager,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./gitlab_dd.nix
    # ./tandoor.nix
    # ./postgres.nix
    ./cloudflared.nix
    ./static_page.nix
    ./jellyfin.nix
    ./transmission.nix
    ./minecraft.nix
    ./arr.nix
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

  home-manager = {
    users.ilya = {
      imports = [
        ../../modules/direnv.nix
        ../../modules/git.nix
      ];
      home.stateVersion = "24.11";
    };
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

  environment.systemPackages =
    with pkgs;
    [
      neofetch
      nmap
      btrfs-progs
      cloudflared
      systemctl-tui
      btop
    ]
    ++ [
      charmbracelet-nur.packages.${pkgs.system}.melt
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
