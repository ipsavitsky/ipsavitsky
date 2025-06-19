{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  programs.mods = {
    enable = true;
    package = inputs.charmbracelet-nur.packages.${pkgs.system}.mods;
    enableBashIntegration = true;
    settings = {
      default-model = "qwen3:14b";
      quiet = false;
      status-text = "Generating";
      theme = "dracula";
      fanciness = 10;
      mcp-servers = {
        filesystem = {
          command = lib.getExe' inputs.sb_mcp.packages."x86_64-linux".default "sb_mcp";
        };
      };
      apis = {
        ollama = {
          base-url = "http://localhost:11434/api";
          models = {
            "qwen3:14b" = {
              max-input-chars = 650000;
            };
          };
        };
      };
    };
  };
}
