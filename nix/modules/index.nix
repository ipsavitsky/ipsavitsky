{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  programs.nix-index = {
    enable = true;
    package = inputs.nix-index-database.packages.${pkgs.system}.default;
  };
  programs.nix-index-database.comma.enable = true;
}
