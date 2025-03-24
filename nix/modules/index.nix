{ nix-index-database, pkgs, ... }:
{
  imports = [
    nix-index-database.hmModules.nix-index
  ];

  programs.nix-index = {
    enable = true;
    package = nix-index-database.packages.${pkgs.system}.default;
  };
  programs.nix-index-database.comma.enable = true;
}
