{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    package = pkgs.btop;
  };
}
