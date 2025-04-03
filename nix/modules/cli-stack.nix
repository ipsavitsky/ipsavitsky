{
  pkgs,
  gitu,
  script-pile,
  nix-tree,
  nix-melt,
  ...
}:
{
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    ./emacs.nix
    ./fzf.nix
    ./git.nix
    ./zellij.nix
    ./mods.nix
    ./helix.nix
    ./starship.nix
    ./index.nix
    ./newsboat.nix
    ./fd.nix
    ./ripgrep.nix
    ./btop.nix
    ./pandoc.nix
    ./yazi.nix
  ];

  home.packages =
    with pkgs;
    [
      tree
      cloc
      circumflex
      systemctl-tui
      dive
      glab
      agg
      asciinema
      difftastic
      mani
    ]
    ++ [
      gitu.packages.${pkgs.system}.default
      script-pile.packages.${pkgs.system}.plot_loc
      nix-tree.packages.${pkgs.system}.default
      nix-melt.packages.${pkgs.system}.default
    ];
}
