{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    shellIntegration.enableBashIntegration = true;
  };
}
