{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    config = {
      theme = "Dracula";
      italic-text = "always";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batwatch
      batgrep
      batdiff
    ];
  };
}
