{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./blocky.nix
    ./hardware-configuration.nix
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

  environment.systemPackages =
    with pkgs;
    with inputs;
    [
      neofetch
      nmap
      systemctl-tui
      btop

      charmbracelet-nur.packages.${pkgs.system}.melt
    ];

  # https://github.com/NixOS/nixos-hardware/issues/858
  boot.initrd.systemd.tpm2.enable = false;

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

  nix.settings.trusted-users = [ "ilya" ];

  system.stateVersion = "24.11";
}
