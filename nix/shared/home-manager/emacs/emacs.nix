{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraConfig = builtins.readFile ./emacs.el;
    extraPackages = epkgs: [
      epkgs.magit
      epkgs.dracula-theme
      epkgs.nix-mode
      epkgs.which-key
      epkgs.undo-tree
    ];
  };
}
