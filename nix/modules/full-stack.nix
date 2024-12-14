{ ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty/kitty.nix
    # ./dconf/dconf.nix
    ./mods/mods.nix
  ];

  home.stateVersion = "24.11";
}
