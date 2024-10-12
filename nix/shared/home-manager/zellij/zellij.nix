{ ... }: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      theme = "dracula";
      simplified_ui = true;
    };
  };
}
