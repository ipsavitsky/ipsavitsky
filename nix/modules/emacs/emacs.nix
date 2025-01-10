{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraPackages =
      epkgs: with epkgs; [
        magit
        dracula-theme
        which-key
        undo-tree
        all-the-icons
        direnv

        corfu
        vertico
        marginalia
        orderless
        nerd-icons-corfu

        go-mode
        markdown-mode
        terraform-mode
        nix-mode
        haskell-mode
        python-mode
        yaml-mode
        elm-mode
        zig-mode
      ];
  };

  # Can't set this as part of extraConfig because it doesn't allow (inhibit-startup-screen)
  home.file.".config/emacs/" = {
    source = ./emacs-confs;
    recursive = true;
  };
}
