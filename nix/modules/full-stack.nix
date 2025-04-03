{ pkgs, ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty.nix
    ./ghostty.nix
    ./dconf.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    localsend
  ];
}
