{ ... }:
{
  services = {
    tandoor-recipes = {
      enable = true;
      port = 8888;
    };

    nginx.virtualHosts."_" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 80;
        }
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8888";
      };
    };
  };
}
