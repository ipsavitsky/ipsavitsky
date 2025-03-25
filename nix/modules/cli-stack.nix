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
    ./newsboat.nix
    ./fd.nix
    ./ripgrep.nix
    ./btop.nix
    ./pandoc.nix
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
      gitu.packages.${pkgs.system}.gitu
    ];
}
