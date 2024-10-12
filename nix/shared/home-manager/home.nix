{ config, lib, pkgs, ... }: {
  home = {
    stateVersion = "24.05"; # Match with nixpkgs version
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
