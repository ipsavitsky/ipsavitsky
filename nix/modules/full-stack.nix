{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./cli-stack.nix
    ./kitty.nix
    ./ghostty.nix
    ./dconf.nix
    ./zed.nix

    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "app.zen_browser.zen"
    ];
  };

  home.packages = with pkgs; [
    (config.lib.nixGL.wrap localsend)
  ];
}
