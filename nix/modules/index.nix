{ nix-index-database, pkgs, ... }:
{
  programs.nix-index = {
    enable = true;
    package = nix-index-database.packages.${pkgs.system}.default;
  };
  programs.nix-index-database.comma.enable = true;
}
