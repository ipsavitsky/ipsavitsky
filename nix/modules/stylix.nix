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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    image = config.lib.stylix.pixel "base01";
  };
}
