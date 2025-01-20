{ pkgs, mods-hm, ... }:
{
  imports = [
    mods-hm.homeManagerModules.mods
  ];

  programs.mods = {
    enable = true;
    package = pkgs.mods;
    enableBashIntegration = true;
    settings = {
      default-model = "phi4";
      quiet = false;
      status-text = "Generating";
      theme = "dracula";
      apis = {
        ollama = {
          base-url = "http://localhost:11434/api";
          models = {
            "llama3.2" = {
              max-input-chars = 650000;
            };
            "phi4" = {
              max-input-chars = 650000;
            };
          };
        };
      };
    };
  };
}
