{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./nothingverse.nix
    ./gitlab_dd.nix
    ./miniflux.nix
    ./cloudflared.nix
    ./matrix.nix
    # ./caddy-static.nix
    ./ntfy-sh.nix
    ./static_page.nix
    ./silverbullet.nix
    ./renovate.nix
    ./jellyfin.nix
    ./transmission.nix
    ./arr.nix
    ./paperless.nix
    ./interlinked.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/London";

  networking = {
    hostName = "apollo";
    useDHCP = true;
    firewall.allowedTCPPorts = [
      22
      80
      443
    ];
  };

  users.users = {
    # root.initialPassword = "root";
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
    cloudflared
    systemctl-tui
    btop
    btrfs-progs

    nur.repos.charmbracelet.melt
  ];

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        X11Forwarding = false;
        PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    fail2ban.enable = true;
  };

  sops = {
    defaultSopsFile = ../../secrets/demeter.yaml;
    age.keyFile = "/home/ilya/.config/sops/age/keys.txt";
  };

  nix.settings.trusted-users = [ "ilya" ];

  system.stateVersion = "24.11";
}
