{ pkgs, config, ... }: # Added 'config' to the arguments

{
  sops.secrets."bash/api_keys.sh" = {
    sopsFile = ../../secrets/hm.yaml;
  };

  programs.bash = {
    enable = true;
    package = pkgs.bash;
    enableVteIntegration = true;
    initExtra = ''
      source "${config.sops.secrets."bash/api_keys.sh".path}"
    '';
  };
}
