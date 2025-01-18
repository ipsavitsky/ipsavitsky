{ ... }:
{
  services = {
    postgresql = {
      enable = true;
      dataDir = "/data/postgresql";
      ensureDatabases = [ "tandoor_recipes" ];
      ensureUsers = [
        {
          name = "tandoor_recipes";
          ensureDBOwnership = true;
        }
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /data/postgresql 0700 postgres postgres -"
  ];
}
