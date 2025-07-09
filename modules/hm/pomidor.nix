{ config, inputs, ... }:
{
  imports = [ inputs.pomidor.homeManagerModules.pomidor ];

  programs.pomidor = {
    enable = true;
    settings = {
      ntfy = {
        url = "http://ntfy.savitsky.dev";
        topic = "pomidor";
        token_file = config.sops.secrets."pomidor/ntfy_token".path;
      };
    };
  };

  sops.secrets."pomidor/ntfy_token" = {
    sopsFile = ../../secrets/hm.yaml;
  };
}
