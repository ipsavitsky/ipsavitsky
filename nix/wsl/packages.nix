{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Coding stuff
    gnumake
    gcc
    python3
    R
    go
    ghc
    rustup
    cmake

    # DevOps stuff
    terraform
    podman
    helm
    kind

    # CLI utils
    neofetch
    file
    tree
    wget
    git
    htop
    nix-index
    zip
    unzip
    ffmpeg
    openssl
    bat
    zellij

    # Other
    home-manager
  ];

  fonts.packages = with pkgs; [
      fira-code
  ];
}
