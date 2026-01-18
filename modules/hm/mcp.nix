{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  sops.secrets."mcp/context7_token" = {
    sopsFile = ../../secrets/hm.yaml;
  };

  sops.secrets."renovate/github_com" = {
    sopsFile = ../../secrets/demeter.yaml;
  };

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
      context7 = {
        url = "https://mcp.context7.com/mcp";
        headers = {
          CONTEXT7_API_KEY = "{file:${config.sops.secrets."mcp/context7_token".path}}";
        };
      };
      github = {
        url = "https://api.githubcopilot.com/mcp/x/repos/readonly";
        headers = {
          Authorization = "Bearer {file:${config.sops.secrets."renovate/github_com".path}}";
        };
      };
    };
  };
}
