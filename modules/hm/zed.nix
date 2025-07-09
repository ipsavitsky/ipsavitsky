{
  pkgs,
  inputs,
  lib,
  ...
}:
{
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
    ];
    userSettings = {
      telemetry.metrics = false;
      format_on_save = "off";
      languages.Nix.language_servers = [
        "nil"
        "!nixd"
      ];
      load_direnv = "shell_hook";
      language_models = {
        ollama = {
          api_url = "http://localhost:11434";
          available_models = [
            {
              name = "qwen3:14b";
              display_name = "qwen3 tool use";
              max_tokens = 32768;
              supports_tools = true;
              supports_thinking = true;
            }
          ];
        };
      };
      context_servers = {
        silverbullet = {
          source = "custom";
          command = lib.getExe' inputs.sb_mcp.packages."x86_64-linux".default "sb_mcp";
          args = [ ];
          env = { };
        };
      };
    };
  };

  home.packages = with pkgs; [
    package-version-server
  ];
}
