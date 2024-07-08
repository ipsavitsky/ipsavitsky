{ pkgs, rust-overlay, ... }: {
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
    btop
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
    emacs-git

    # Dev packages
    dockfmt
    podman
    
    terraform
    terraform-ls

    gcc
    libclang
    
    clojure
    cljfmt

    go
    gopls
    gomodifytags
    gotests
    gore
    gotools

    ghc
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

    shfmt
    shellcheck

    libxml2
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

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
        url    = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "1p1lfl6hg9g3n3bzd1frn9s2ihmsssz5phfxpyafz9kh08j7qknj";
    }))
  ];
}
