{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  sops.secrets."mods/silverbullet_token" = {
    sopsFile = ../../secrets/hm.yaml;
  };

  programs.zed-editor = {
    enable = true;
    package = inputs.zed.packages.${pkgs.system}.default;
    extensions = [
      "nix"
      "rust"
      "python"
      "bash"
      "go"
      "zig"
      "d"
      "svelte"
      "toml"
      "elisp"
      "solidity"
      "terraform"
      "c#"
      "ruby"
    ];
    userSettings = {
      telemetry.metrics = false;
      format_on_save = "off";
      languages = {
        Nix.language_servers = [
          "nil"
          "!nixd"
        ];

        Python.language_servers = [
          "basedpyright"
          "ty"
          "ruff"
        ];
      };
      load_direnv = "shell_hook";
      buffer_font_features = {
        ligatures = false;
      };
      edit_predictions = {
        mode = "subtle";
      };
      language_models = {
        openai_compatible = {
          zai = {
            api_url = "https://api.z.ai/api/coding/paas/v4";
            available_models = [
              {
                name = "glm-5.1";
                display_name = "GLM-5.1";
                max_tokens = 200000;
                max_output_tokens = 131072;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
              {
                name = "glm-4.7";
                display_name = "GLM-4.7";
                max_tokens = 200000;
                max_output_tokens = 128000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
              {
                name = "glm-5-turbo";
                display_name = "GLM-5 Turbo";
                max_tokens = 200000;
                max_output_tokens = 131072;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
              {
                name = "glm-4.7-flashx";
                display_name = "GLM-4.7-FlashX";
                max_tokens = 200000;
                max_output_tokens = 128000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
              {
                name = "glm-4.7-flash";
                display_name = "GLM-4.7-Flash";
                max_tokens = 200000;
                max_output_tokens = 128000;
                capabilities = {
                  tools = true;
                  images = false;
                  parallel_tool_calls = true;
                  prompt_cache_key = true;
                };
              }
            ];
          };
        };
      };
      context_servers = {
        silverbullet = {
          command = lib.getExe' inputs.sb_mcp.packages.${pkgs.system}.default "sb_mcp";
          args = [
            "--url"
            "http://notes.savitsky.dev"
            "--token-file"
            config.sops.secrets."mods/silverbullet_token".path
          ];
          env = { };
        };
      };
      agent = {
        dock = "left";
      };
      agent_servers = {
        opencode = {
          type = "custom";
          command = lib.getExe' inputs.nix-ai-tools.packages.${pkgs.system}.opencode "opencode";
          args = [
            "acp"
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    package-version-server
  ];
}
