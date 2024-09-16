{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraPackages = epkgs: [
      epkgs.magit
      epkgs.dracula-theme
      epkgs.nix-mode
      epkgs.which-key
      epkgs.undo-tree
    ];
  };

  home.file.".config/emacs/init.el".source = ./emacs.el;
}
