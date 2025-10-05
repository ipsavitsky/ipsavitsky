_: {
  services.matrix-conduit = {
    enable = true;
    settings = {
      global = {
        server_name = "matrix.savitsky.dev";
        enable_lightning_bolt = false;
        allow_encryption = true;
        allow_federation = true;
        allow_registration = true;
        database_backend = "rocksdb";
      };
    };
  };
}
