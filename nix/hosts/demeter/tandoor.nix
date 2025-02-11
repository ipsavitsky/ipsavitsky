{ config, ... }:
{
  services = {
    tandoor-recipes = {
      enable = true;
      port = 8410;
      address = "localhost";
      extraConfig = {
        SECRET_KEY_FILE = config.sops.secrets."tandoor/secret_key".path;
        POSTGRES_HOST = "/run/postgresql";
        POSTGRES_DB = "tandoor_recipes";
        POSTGRES_USER = "tandoor_recipes";
        DB_ENGINE = "django.db.backends.postgresql";
        # MEDIA_ROOT = "/data/tandoor_recipes/media";
      };
    };
  };

  systemd.services = {
    tandoor-recipes = {
      after = [ "postgresql.service" ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /data/tandoor_recipes 0700 tandoor_recipes tandoor_recipes -"
  ];

  sops.secrets."tandoor/secret_key" = { };
}
