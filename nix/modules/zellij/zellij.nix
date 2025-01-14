{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    enableBashIntegration = true;
    settings = {
      # theme = "dracula";
      # simplified_ui = true;
    };
  };
}
