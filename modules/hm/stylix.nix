{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    image = config.lib.stylix.pixel "base01";
    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.lato;
        name = "Lato";
      };
      monospace = {
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono Nerd Font";
      };
      emoji = config.stylix.fonts.sansSerif;
    };
  };
}
