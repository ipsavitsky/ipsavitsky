{
  pkgs,
  inputs,
  ...
}:
{
  programs.mods = {
    enable = true;
    package = inputs.charmbracelet-nur.packages.${pkgs.system}.mods;
    enableBashIntegration = true;
    settings = {
      default-model = "gemma3:12b";
      quiet = false;
      status-text = "Generating";
      theme = "dracula";
      fanciness = 10;
      apis = {
        ollama = {
          base-url = "http://localhost:11434/api";
          models = {
            "llama3.2" = {
              max-input-chars = 650000;
            };
            "gemma3:12b" = {
              max-input-chars = 650000;
            };
          };
        };
      };
    };
  };
}
