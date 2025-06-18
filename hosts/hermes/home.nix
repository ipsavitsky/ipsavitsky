{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ../../modules/full-stack.nix
    ../../modules/stylix.nix
  ];

  services.flatpak = {
    packages = [
      "dev.zed.Zed"
    ];
  };

  # for some reason kde gets enabled and breaks gnome configuration when set??
  stylix = {
    polarity = "dark";
    targets.kde.enable = false;
  };

  home = {
    stateVersion = "24.11";
    username = "ilya";
    homeDirectory = "/home/ilya";

    packages =
      with pkgs;
      with inputs;
      [
        opentofu
        skopeo
        taplo
        gopls
        go-tools
        terraform-docs
        shellcheck
        checkov
        yubikey-manager
        helm-ls
        mermaid-cli
        yaml-language-server
        bash-language-server
        renovate
        mdbook
        quasselClient

        charmbracelet-nur.packages.${pkgs.system}.vhs
        charmbracelet-nur.packages.${pkgs.system}.gum
        nom.packages.${pkgs.system}.default
        statix.packages.${pkgs.system}.default
        deadnix.packages.${pkgs.system}.default
      ];
  };

  programs = {
    # we disable zed in favor of installing a flatpak
    zed-editor.enable = lib.mkForce false;
    bash = {
      initExtra = ''
        source "$HOME/.cargo/env"
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

    k9s = {
      enable = true;
      package = pkgs.k9s;
    };
  };

  sops.age.keyFile = "/home/ilya/.config/sops/age/keys.txt";
}
