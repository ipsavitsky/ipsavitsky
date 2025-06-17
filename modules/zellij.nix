{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    enableBashIntegration = true;
  };
}
