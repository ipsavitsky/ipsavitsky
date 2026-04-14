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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/moonlight1.yaml";
    image = ./artemis-ii-moon.jpg;
    polarity = "dark";
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
    targets.zen-browser.profileNames = [ "default" ];
  };
}
