{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    settings = {
      keybinds = {
        normal = {
          "bind \"Alt m\"" = {
            "Run \"zemon\"" = {
              floating = true;
              close_on_exit = true;
            };
          };
        };
      };
      show_startup_tips = false;
    };
    enableBashIntegration = true;
  };
}
