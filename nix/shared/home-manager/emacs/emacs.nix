{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraPackages = epkgs: with epkgs; [
      magit
      dracula-theme
      which-key
      undo-tree
      dirvish
      all-the-icons
      helm
      helm-icons
      direnv

      corfu
      cape
      nerd-icons-corfu

      go-mode
      terraform-mode
      nix-mode
      haskell-mode
    ];
  };

  # Can't set this as part of extraConfig because it doesn't allow (inhibit-startup-screen)
  home.file.".config/emacs/" = {
    source = ./emacs-confs;
    recursive = true;
  };
}
