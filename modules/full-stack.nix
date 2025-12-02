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
    ./hm/halloy.nix

    inputs.zen-browser.homeModules.beta
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adawita";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "helium.desktop";
      "x-scheme-handler/http" = "helium.desktop";
      "x-scheme-handler/https" = "helium.desktop";
      "x-scheme-handler/about" = "helium.desktop";
      "x-scheme-handler/unknown" = "helium.desktop";
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
    dorion
    nur.repos.forkprince.helium-nightly
  ];

  programs.zen-browser.enable = true;
}
