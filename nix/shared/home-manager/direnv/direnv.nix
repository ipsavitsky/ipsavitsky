{ ... }: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    config = {
      global = {
        warn_timeout = "1m";
      };
    };
    nix-direnv.enable = true;
  };
}
