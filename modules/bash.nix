{ pkgs, ... }:
{
  programs.bash = {
    enable = true;
    package = pkgs.bash;
    enableVteIntegration = true;
  };
}
