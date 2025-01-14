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
      default-model = "llama3.2";
      apis = {
        ollama = {
          base-url = "http://localhost:11434/api";
          models = {
            "llama3.2" = {
              max-input-chars = 650000;
            };
          };
        };
      };
    };
  };
}
