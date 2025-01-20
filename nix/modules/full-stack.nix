{ ... }:
{
  imports = [
    ./cli-stack.nix
    ./kitty.nix
    ./ghostty.nix
    ./dconf.nix
    ./zed.nix
  ];

  home.stateVersion = "24.11";
}
