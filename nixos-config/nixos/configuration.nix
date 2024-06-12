{ inputs, ... }: {
  imports = [ ./packages.nix ./hardware-configuration.nix ./modules/bundle.nix ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features =
    [ "nix-command" "flakes" ]; # Enabling flakes

  system.stateVersion = "24.05";
}
