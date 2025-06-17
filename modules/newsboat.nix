{ config, ... }:
{
  sops.secrets."newsboat/miniflux_token" = {
    sopsFile = ../secrets/hm.yaml;
  };

  programs.newsboat = {
    enable = true;
    extraConfig = ''
      urls-source "miniflux"
      miniflux-url "https://flux.savitsky.dev"
      miniflux-tokenfile "${config.sops.secrets."newsboat/miniflux_token".path}"
    '';
  };
}
