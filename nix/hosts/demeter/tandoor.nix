{ config, lib, ... }:
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
        MEDIA_ROOT = "/data/tandoor_recipes";
        GUNICORN_MEDIA = "1";
      };
    };
  };

  users.users.tandoor_recipes = {
    name = "tandoor_recipes";
    group = "tandoor";
    isSystemUser = true;
  };
  users.groups.tandoor = { };

  systemd.services = {
    tandoor-recipes = {
      after = [ "postgresql.service" ];
      serviceConfig = {
        DynamicUser = lib.mkForce false;
        Group = lib.mkForce "tandoor";
        User = lib.mkForce "tandoor_recipes";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /data/tandoor_recipes 0700 tandoor_recipes tandoor -"
  ];

  sops.secrets."tandoor/secret_key" = {
    owner = "tandoor_recipes";
  };
}
