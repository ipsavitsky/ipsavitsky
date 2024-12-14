{ ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty/kitty.nix
    ./dconf/dconf.nix
  ];

  home.stateVersion = "24.11";
}
