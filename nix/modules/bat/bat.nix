{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    config = {
      theme = "Dracula";
      italic-text = "always";
    };
  };
}
