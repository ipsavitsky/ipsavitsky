{ pkgs, yazi, ... }:
{
  programs.yazi = {
    enable = true;
    package = yazi.packages.${pkgs.system}.default;
    enableBashIntegration = true;
  };
}
