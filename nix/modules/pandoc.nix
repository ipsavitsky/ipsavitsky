{ pkgs, ... }:
{
  programs.pandoc = {
    enable = true;
    package = pkgs.pandoc_3_5;
  };
}
