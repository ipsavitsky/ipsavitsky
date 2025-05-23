{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
    extraPackages =
      epkgs: with epkgs; [
        magit
        dirvish
        which-key
        undo-tree
        all-the-icons
        direnv
        mistty

        ob-mermaid
        org-modern

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
        lua-mode
        rust-mode
        d-mode
        js2-mode
        typescript-mode
        tuareg
        renpy
        gleam-ts-mode
        jsonnet-mode
      ];
  };

  home.packages = with pkgs; [
    tree-sitter-grammars.tree-sitter-gleam
  ];

  # Can't set this as part of extraConfig because it doesn't allow (inhibit-startup-screen)
  home.file.".config/emacs/" = {
    source = ./emacs-confs;
    recursive = true;
  };

  home.file.".config/emacs/mermaid.el".text = ''
    (setq ob-mermaid-cli-path "${pkgs.mermaid-cli}/bin/mmdc")

    (org-babel-do-load-languages
        'org-babel-load-languages
        '((mermaid . t)))
  '';
}
