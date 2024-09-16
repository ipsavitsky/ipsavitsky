{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraPackages = epkgs: [
      epkgs.magit
      epkgs.dracula-theme
      epkgs.which-key
      epkgs.undo-tree
      epkgs.dirvish
    ];
  };
  
  # Can't set this as part of extraConfig because it doesn't allow (inhibit-startup-screen)
  home.file.".config/emacs/init.el".source = ./emacs.el;
}
