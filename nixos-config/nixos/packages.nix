{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    alacritty
    obs-studio
    discord
    gparted
    firefox
    thunderbird
    quassel

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

    # Sound
    pipewire
    pulseaudio
    pamixer

    # Other
    home-manager
  ];

  fonts.packages = with pkgs; [
      fira-code
  ];
}
