{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  sops.secrets."mods/silverbullet_token" = {
    sopsFile = ../../secrets/hm.yaml;
  };

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
      topp = 1;
      mcp-servers = {
        silverbullet = {
          command = lib.getExe' inputs.sb_mcp.packages.${pkgs.system}.default "sb_mcp";
          args = [
            "--url"
            "http://notes.savitsky.dev"
            "--token-file"
            config.sops.secrets."mods/silverbullet_token".path
          ];
        };
      };
      apis = {
        ollama = {
          base-url = "http://localhost:11434/api";
          models = {
            "gemma3:12b" = {
              max-input-chars = 650000;
            };
            "magistral:24b" = {
              max-input-chars = 650000;
            };
          };
        };
        anthropic = {
          base-url = "https://api.anthropic.com/v1";
          api-key-env = "ANTHROPIC_API_KEY";
          models = {
            "claude-3-7-sonnet-latest" = {
              aliases = [
                "claude"
              ];
              max-input-chars = 680000;
            };
          };
        };
        google = {
          api-key-env = "GOOGLE_API_KEY";
          models = {
            "gemini-2.5-flash" = {
              aliases = [
                "gemini"
              ];
              max-input-chars = 4194304;
            };
          };
        };
        mistral = {
          base-url = "https://api.mistral.ai/v1";
          api-key-env = "MISTRAL_API_KEY";
          models = {
            "mistral-large-latest" = {
              aliases = [
                "mistral"
              ];
              max-input-chars = 384000;
            };
          };
        };
      };
    };
  };
}
