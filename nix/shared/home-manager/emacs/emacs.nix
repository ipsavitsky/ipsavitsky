{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraPackages = epkgs: [
      epkgs.use-package
      epkgs.magit
      epkgs.dracula-theme
      epkgs.nix-mode
      epkgs.which-key
      # epkgs.helm
      epkgs.undo-tree
    ];
  };
  
  home.file.".config/emacs/init.el".source = ./emacs.el;
}
