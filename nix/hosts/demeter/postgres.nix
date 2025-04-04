_: {
  services = {
    postgresql = {
      enable = true;
      dataDir = "/data/postgresql";
    };
  };

  systemd.tmpfiles.rules = [
    "d /data/postgresql 0700 postgres postgres -"
  ];
}
