{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    themeFile = "Dracula";
    font = {
      name = "Fira Code";
    };
    shellIntegration.enableBashIntegration = true;
  };
}
