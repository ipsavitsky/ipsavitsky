{ pkgs, gitu, ... }:
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
  ];

  home.packages =
    with pkgs;
    [
      tree
      cloc
      fd
      ripgrep
      btop
      circumflex
      systemctl-tui
      systemctl-tui
      dive
      glab
      agg
      asciinema
      difftastic
      pandoc_3_5
      mani
    ]
    ++ [
      gitu.packages.${pkgs.system}.gitu
    ];
}
