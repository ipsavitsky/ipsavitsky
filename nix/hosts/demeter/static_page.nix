{ pkgs, savitsky-dev, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."personal_page" = {
      root = "${savitsky-dev.packages.${pkgs.system}.default}/static";
      listen = [
        {
          addr = "127.0.0.1";
          port = 1234;
        }
      ];
    };
  };
}
