{ config, ... }:
{
  services = {
    tandoor-recipes = {
      enable = true;
      port = 8888;
      extraConfig = {
        SECRET_KEY_FILE = config.sops.secrets."tandoor/secret_key".path;
        POSTGRES_HOST = "/run/postgresql";
        POSTGRES_DB = "tandoor_recipes";
        POSTGRES_USER = "tandoor_recipes";
        DB_ENGINE = "django.db.backends.postgresql";
      };
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

  systemd.services = {
    tandoor-recipes = {
      after = [ "postgresql.service" ];
    };
  };

  sops.secrets."tandoor/secret_key" = { };
}
