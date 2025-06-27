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
    inputs.script-pile.packages."x86_64-linux".wl-screenshot
    inputs.wdisplays.packages."x86_64-linux".default
  ];
}
