{ ... }:
{
  imports = [
    ./bash/bash.nix
    ./bat/bat.nix
    ./direnv/direnv.nix
    ./emacs/emacs.nix
    ./fzf/fzf.nix
    ./git/git.nix
    ./zellij/zellij.nix
    ./mods/mods.nix
  ];

  home.stateVersion = "24.11";
}
