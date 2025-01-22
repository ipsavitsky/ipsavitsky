{ config, ... }:
{
  services = {
    tandoor-recipes = {
      enable = true;
      extraConfig = {
        SECRET_KEY_FILE = config.sops.secrets."tandoor/secret_key".path;
        POSTGRES_HOST = "/run/postgresql";
        POSTGRES_DB = "tandoor_recipes";
        POSTGRES_USER = "tandoor_recipes";
        DB_ENGINE = "django.db.backends.postgresql";
        MEDIA_ROOT = "/data/tandoor-recipes/media";
      };
    };

    nginx.virtualHosts."recipe.savitsky.dev" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.tandoor-recipes.port}";
      };
    };
  };

  systemd.services = {
    tandoor-recipes = {
      after = [ "postgresql.service" ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /data/tandoor-recipes 0700 tandoor-recipes tandoor-recipes -"
  ];

  sops.secrets."tandoor/secret_key" = { };
}
