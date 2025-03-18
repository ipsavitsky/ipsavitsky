{ ... }:
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
  ];

  home.stateVersion = "24.11";
}
