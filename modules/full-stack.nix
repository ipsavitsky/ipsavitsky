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
  ];

  home.packages = with pkgs; [
    localsend
    pavucontrol
    firefox
    fractal
  ];
}
