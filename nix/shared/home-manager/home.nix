{ config, lib, pkgs, ... }: {
  home = {
    stateVersion = "24.11";
  };

  imports = [
    ./bash/bash.nix
    ./emacs/emacs.nix
    ./git/git.nix
    ./zellij/zellij.nix
    ./fzf/fzf.nix
    ./bat/bat.nix
    ./direnv/direnv.nix
  ];
}
