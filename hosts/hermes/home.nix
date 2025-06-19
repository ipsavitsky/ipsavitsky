{
  pkgs,
  inputs,
  ...
}:
{
  home = {
    username = "ilya";
    homeDirectory = "/home/ilya";

    packages =
      with pkgs;
      with inputs;
      [
        yubikey-manager
        quasselClient

        charmbracelet-nur.packages.${pkgs.system}.vhs
        charmbracelet-nur.packages.${pkgs.system}.gum
        nom.packages.${pkgs.system}.default
        statix.packages.${pkgs.system}.default
        deadnix.packages.${pkgs.system}.default
      ];
  };

  programs = {
    k9s = {
      enable = true;
      package = pkgs.k9s;
    };
  };
}
