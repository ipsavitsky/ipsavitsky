{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    config = {
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
