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
    htop
    nix-index
    zip
    unzip
    ffmpeg
    openssl
    bat
    zellij
    fzf

    # Emacs stuff
    git
    ripgrep
    coreutils
    fd
    clang
    emacs

    # Dev packages
    dockfmt
    terraform
    libclang
    cljfmt
    libxml2
    gopls
    gomodifytags
    gotests
    gore
    gotools
    haskell-language-server
    haskellPackages.hoogle
    julia
    python312
    python312Packages.black
    python312Packages.pyflakes
    python312Packages.isort
    python312Packages.pynose
    python312Packages.pytest
    poetry
    pipenv
    gcc
    ghc

    rust-analyzer
    rustc

    shfmt
    shellcheck

    html-tidy
    stylelint
    jsbeautifier

    # Other
    nerdfonts
    fira-code-nerdfont
    emojify
    home-manager
  ];

  fonts.packages = with pkgs; [
    fira-code
  ];
}
