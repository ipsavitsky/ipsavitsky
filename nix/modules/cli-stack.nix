{
  pkgs,
  inputs,
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
    with inputs;
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

      gitu.packages.${pkgs.system}.default
      script-pile.packages.${pkgs.system}.ploc
      nix-tree.packages.${pkgs.system}.default
      nix-melt.packages.${pkgs.system}.default
      charmbracelet-nur.packages.${pkgs.system}.glow
      charmbracelet-nur.packages.${pkgs.system}.melt
      pomidor.packages.${pkgs.system}.default
    ];
}
