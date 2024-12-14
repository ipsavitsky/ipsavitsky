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
    ./mods/mods-config.nix
  ];

  home.stateVersion = "24.11";
}
