_: {
  programs.zed-editor = {
    enable = true;
    # this does not build for some reason
    # package = inputs.zed.packages.${pkgs.system}.default;
    extensions = [
      "nix"
      "rust"
      "python"
      "bash"
    ];
    userSettings = {
      telemetry.metrics = false;
      languages.Nix.language_servers = [
        "nil"
        "!nixd"
      ];
      load_direnv = "shell_hook";
      base_keymap = "Emacs";
      # show_whitespaces = "all";
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
    };
  };
}
