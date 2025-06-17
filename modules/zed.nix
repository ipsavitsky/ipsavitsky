{
  pkgs,
  config,
  inputs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    package = config.lib.nixGL.wrap inputs.zed.packages.${pkgs.system}.default;
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
      show_whitespaces = "all";
    };
  };
}
