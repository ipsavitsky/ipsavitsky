_: {
  services.matrix-conduit = {
    enable = true;
    settings = {
      global = {
        server_name = "matrix.savitsky.dev";
        enable_lightning_bolt = false;
      };
    };
  };
}
