{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hm/bash.nix
    ./hm/bat.nix
    ./hm/direnv.nix
    # ./hm/emacs.nix
    ./hm/fzf.nix
    ./hm/git.nix
    ./hm/zellij.nix
    ./hm/mods.nix
    ./hm/helix.nix
    ./hm/starship.nix
    ./hm/index.nix
    ./hm/newsboat.nix
    ./hm/fd.nix
    ./hm/ripgrep.nix
    ./hm/btop.nix
    ./hm/pandoc.nix
    ./hm/yazi.nix
    ./hm/pomidor.nix

    inputs.try.homeModules.default
  ];

  home.packages =
    with pkgs;
    with inputs;
    [
      tree
      cloc
      circumflex
      systemctl-tui
      dive
      glab
      agg
      asciinema
      difftastic
      mani
      file
      wget
      bitwarden-cli

      gitu.packages.${pkgs.system}.default
      ploc.packages.${pkgs.system}.default
      nix-tree.packages.${pkgs.system}.default
      nix-melt.packages.${pkgs.system}.default
      zemon.packages.${pkgs.system}.default
      nix-ai-tools.packages.${pkgs.system}.crush
      nix-ai-tools.packages.${pkgs.system}.opencode
      terminaltrove.packages.${pkgs.system}.cloctui
      wiremix.packages.${pkgs.system}.wiremix
      wifitui.packages.${pkgs.system}.default
      nom.packages.${pkgs.system}.default
      nvd.packages.${pkgs.system}.nvd
      caligula.packages.${pkgs.system}.default
      home-manager.packages.${pkgs.system}.home-manager

      # have to specify pkgs. so that it doesn't collide with inputs.nur
      pkgs.nur.repos.charmbracelet.glow
      pkgs.nur.repos.charmbracelet.melt
    ];

  programs.try = {
    enable = true;
    path = "~/tries";
  };
}
