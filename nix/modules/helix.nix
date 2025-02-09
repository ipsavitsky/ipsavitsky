{ pkgs, helix, ... }:
{
  programs.helix = {
    enable = true;
    package = helix.packages."${pkgs.system}".default;
    settings = {
      theme = "dracula";
    };
  };
}
