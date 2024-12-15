{ ... }:
{
  programs.mods = {
    enable = true;
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
