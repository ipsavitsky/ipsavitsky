{ pkgs, secret, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."secret_page" = {
      root = "${secret.packages.${pkgs.system}.default}/static";
      listen = [
        {
          addr = "127.0.0.1";
          port = 4321;
        }
      ];
    };
  };
}
