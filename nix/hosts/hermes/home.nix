{
  pkgs,
  charmbracelet-nur,
  nom,
  statix,
  deadnix,
  gitu,
  ...
}:
{
  imports = [ ../../modules/full-stack.nix ];

  home = {
    stateVersion = "24.11";
    username = "ilyasavitsky";
    homeDirectory = "/home/ilyasavitsky";

    packages =
      with pkgs;
      [
        btop
        cowsay
        helm-ls
        ladybird
        opentofu
        skopeo
      ]
      ++ [
        charmbracelet-nur.packages.${pkgs.system}.melt
        charmbracelet-nur.packages.${pkgs.system}.vhs
        nom.packages.${pkgs.system}.default
        statix.packages.${pkgs.system}.default
        deadnix.packages.${pkgs.system}.default
        gitu.packages.${pkgs.system}.default
      ];
  };

  programs.bash = {
    initExtra = ''
      source "$HOME/.cargo/env"
      source "$HOME/.ghcup/env"
      PS1="\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\] "
      BUN_INSTALL="$HOME/.bun";
      GOPATH="$HOME/go";
      GOBIN="$GOPATH/bin";
      PATH="$BUN_INSTALL/bin:/usr/local/go/bin:$PATH";
    '';

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };
  };
}
