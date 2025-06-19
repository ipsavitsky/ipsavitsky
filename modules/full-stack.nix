{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./cli-stack.nix
    ./hm/kitty.nix
    ./hm/ghostty.nix
    ./hm/dconf.nix
    ./hm/zed.nix
    ./hm/ntfyer.nix

    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "app.zen_browser.zen"
    ];
  };

  home.packages = with pkgs; [
    localsend
    pavucontrol
  ];
}
