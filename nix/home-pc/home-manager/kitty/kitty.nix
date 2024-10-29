{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Dracula";
    font = {
      name = "Fira Code";
    };
    shellIntegration.enableBashIntegration = true;
  };
}
