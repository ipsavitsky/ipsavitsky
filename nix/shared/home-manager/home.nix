{ config, lib, pkgs, ... }: {
  home = {
    packages = with pkgs; [
      # Add any other packages you need here
    ];
    
    stateVersion = "24.05"; # Match with nixpkgs version
  };

  imports = [
    ./bash/bash.nix
    ./emacs/emacs.nix
    ./git/git.nix
    ./zellij/zellij.nix
    ./fzf/fzf.nix
    ./bat/bat.nix
  ];
}
