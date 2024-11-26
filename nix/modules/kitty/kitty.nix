{ ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    font = {
      name = "Fira Code";
    };
    shellIntegration.enableBashIntegration = true;
  };
}
