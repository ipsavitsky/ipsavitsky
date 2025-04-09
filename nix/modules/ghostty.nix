{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = config.lib.nixGL.wrap inputs.ghostty.packages."${pkgs.system}".default;
    enableBashIntegration = true;
    installBatSyntax = true;
    settings = {
      font-family = "Fira Code";
      theme = "Dracula";
      window-decoration = false;
      copy-on-select = false;
      shell-integration = "bash";
      app-notifications = "no-clipboard-copy";
    };
  };
}
