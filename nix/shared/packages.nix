{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    cloc
    xclip
    fd
    file
    wget
    circumflex

    home-manager
  ];

  fonts.packages = with pkgs; [
    fira-code
    emacs-all-the-icons-fonts
  ];

  home-manager = {
    users.ilya = ./home-manager/home.nix;
    useGlobalPkgs = true;
  };

  nix.settings.auto-optimise-store = true;

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
