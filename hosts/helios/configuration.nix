{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./soju.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = false;
  networking.hostName = "helios";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGF6pkBKgzxw7EEBJOjCoSoGlcOF3I0yMmHrEmFqXR1R"
  ];

  environment.systemPackages = with pkgs; [
    systemctl-tui
  ];

  system.stateVersion = "23.11";
}
