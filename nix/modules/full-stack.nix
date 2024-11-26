{ ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty/kitty.nix
    ./xfconf/xfconf.nix
  ];

  home.stateVersion = "24.11";
}
