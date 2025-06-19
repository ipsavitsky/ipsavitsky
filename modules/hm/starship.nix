{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableBashIntegration = true;
  };
}
