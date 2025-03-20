{
  pkgs,
  charmbracelet-nur,
  nom,
  statix,
  deadnix,
  ...
}:
{
  imports = [ ../../modules/full-stack.nix ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    image = ../../../assets/background.jpg;
  };

  home = {
    stateVersion = "24.11";
    username = "ilyasavitsky";
    homeDirectory = "/home/ilyasavitsky";

    packages =
      with pkgs;
      [
        opentofu
        skopeo
        taplo
        gopls
        go-tools
        terraform-docs
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
      ]
      ++ [
        charmbracelet-nur.packages.${pkgs.system}.melt
        charmbracelet-nur.packages.${pkgs.system}.vhs
        charmbracelet-nur.packages.${pkgs.system}.gum
        nom.packages.${pkgs.system}.default
        statix.packages.${pkgs.system}.default
        deadnix.packages.${pkgs.system}.default
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
