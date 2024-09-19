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
    ];
  };
  
  # Can't set this as part of extraConfig because it doesn't allow (inhibit-startup-screen)
  home.file.".config/emacs/init.el".source = ./emacs.el;
}
