{ inputs, ... }: {
  imports = [ ./packages.nix ./hardware-configuration.nix ./modules/bundle.nix ];

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "Europe/London"; # Set your time zone.

  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  nix.settings.experimental-features =
    [ "nix-command" "flakes" ]; # Enabling flakes

  system.stateVersion = "23.05";
}
