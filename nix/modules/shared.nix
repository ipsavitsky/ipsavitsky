{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    cloc
    xclip
    fd
    ripgrep
    file
    wget
    circumflex
    btop
    home-manager
  ];

  fonts.packages = with pkgs; [
    fira-code
    emacs-all-the-icons-fonts
  ];

  nix.settings.auto-optimise-store = true;

  services = {
    ollama = {
      enable = true;
      loadModels = [ "phi4" ];
    };
  };

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
