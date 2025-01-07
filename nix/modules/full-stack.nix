{ ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty/kitty.nix
    ./ghostty/ghostty.nix
    ./dconf/dconf.nix
    ./zed/zed.nix
  ];

  home.stateVersion = "24.11";
}
