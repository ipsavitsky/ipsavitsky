{
  pkgs,
  ...
}:
{
  imports = [
    ./cli-stack.nix
    ./hm/kitty.nix
    ./hm/ghostty.nix
    ./hm/zed.nix
    ./hm/ntfyer.nix
    ./hm/halloy.nix
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adawita";
    };
  };

  home.packages = with pkgs; [
    localsend
    pavucontrol
    firefox
    fractal
    tuba
    geary
    bitwarden-desktop
  ];
}
