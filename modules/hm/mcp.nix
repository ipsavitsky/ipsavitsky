{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  programs.mcp = {
    enable = true;
    servers = {
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
  };
}
