{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    package = pkgs.nix-direnv;
    enableBashIntegration = true;
    config = {
      global = {
        warn_timeout = "1m";
      };
    };
    nix-direnv.enable = true;
  };
}
