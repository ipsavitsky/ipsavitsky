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
      context_servers = {
        silverbullet = {
          source = "custom";
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
      agent_servers = {
        opencode = {
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
