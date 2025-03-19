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
        opentofu
        skopeo
        taplo
        agg
        asciinema
        difftastic
        fd
        systemctl-tui
        dive
        glab
        gopls
        go-tools
        terraform-docs
        pandoc_3_5
        shellcheck
        checkov
        pipenv
        poetry
        uv
        yubikey-manager
        helm-ls
        mermaid-cli
        yaml-language-server
        bash-language-server
        renovate
        mani
      ]
      ++ [
        charmbracelet-nur.packages.${pkgs.system}.melt
        charmbracelet-nur.packages.${pkgs.system}.vhs
        charmbracelet-nur.packages.${pkgs.system}.gum
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
