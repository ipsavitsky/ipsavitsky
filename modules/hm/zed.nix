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
      "elisp"
      "solidity"
    ];
    userSettings = {
      telemetry.metrics = false;
      format_on_save = "off";
      languages.Nix.language_servers = [
        "nil"
        "!nixd"
      ];
      load_direnv = "shell_hook";
      context_servers = {
        silverbullet = {
          source = "custom";
          command = lib.getExe' inputs.sb_mcp.packages.${pkgs.system}.default "sb_mcp";
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
