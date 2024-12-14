{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.programs.mods;
  yamlFormat = pkgs.formats.yaml { };
in
{
  options.programs.mods = {
    enable = mkEnableOption "mods";

    package = mkOption {
      type = types.package;
      default = pkgs.mods;
    };

    settings = mkOption {
      type = yamlFormat.type;
      default = { };
    };

    enableBashIntegration = mkOption {
      default = false;
    };

    enableZshIntegration = mkOption {
      default = false;
    };

    enableFishIntegration = mkOption {
      default = false;
    };
  };

  config = {
    home.packages = [ cfg.package ];

    xdg.configFile."mods/mods.yml" = mkIf (cfg.settings != { }) {
      source = yamlFormat.generate "mods.yml" cfg.settings;
    };

    programs.bash.initExtra = mkIf cfg.enableBashIntegration (
      mkOrder 200 ''
        source <(mods completion bash)
      ''
    );

    programs.zsh.initExtra = mkIf cfg.enableZshIntegration (
      mkOrder 200 ''
        source <(mods completion zsh)
      ''
    );

    programs.fish.interactiveShellInit = mkIf cfg.enableFishIntegration (
      mkOrder 200 ''
        mods completion fish | source
      ''
    );
  };
}
