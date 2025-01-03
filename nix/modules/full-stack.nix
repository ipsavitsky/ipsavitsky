{ ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty/kitty.nix
    ./ghostty/ghostty.nix
    ./dconf/dconf.nix
  ];

  home.stateVersion = "24.11";
}
