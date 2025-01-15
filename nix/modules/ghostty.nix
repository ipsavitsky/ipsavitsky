{
  pkgs,
  ghostty,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    package = ghostty.packages."${pkgs.system}".default;
    enableBashIntegration = true;
    installBatSyntax = true;
    settings = {
      font-family = "Fira Code";
      theme = "Dracula";
      window-decoration = false;
      copy-on-select = false;
    };
  };
}
