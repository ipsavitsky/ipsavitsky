{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
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
    emacs
    fzf

    # Other
    home-manager
  ];
}
