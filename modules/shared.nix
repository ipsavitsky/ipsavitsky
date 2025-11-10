{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  fonts.packages = with pkgs; [
    fira-code
    emacs-all-the-icons-fonts
  ];

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
  };

  services.ollama =
    let
      unstable_pkgs = import inputs.nixpkgs-unstable {
        inherit (pkgs) system;
        config = {
          allowUnfreePredicate =
            pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "cuda_cudart"
              "cuda_nvcc"
              "cuda_cccl"
              "libcublas"
            ];
          allowBroken = true;
        };
      };
    in
    {
      enable = true;
      package = unstable_pkgs.ollama;
    };

  programs = {
    nekoray = {
      enable = true;
      tunMode.enable = true;
    };
    nix-ld.enable = true;
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
