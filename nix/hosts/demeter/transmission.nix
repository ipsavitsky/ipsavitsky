{ pkgs, ... }:
{
  users.groups.transmission = { };

  users.users.transmission = {
    name = "transmission";
    group = "transmission";
    isSystemUser = true;
  };

  systemd.tmpfiles.rules = [
    "d /data/transmission 0700 transmission transmission -"
  ];

  systemd.services.transmission = {
    serviceConfig = {
      BindPaths = "/data";
    };
  };

  services.transmission = {
    enable = true;
    user = "transmission";
    group = "transmission";
    home = "/data/transmission";
    package = pkgs.transmission_4;
    webHome = pkgs.flood-for-transmission;
    openPeerPorts = true;
    openRPCPort = true;
    downloadDirPermissions = "0777";
    settings = {
      message-level = 3;
      incomplete-dir-enabled = false;
      # speed-limit-up = 500;
      # speed-limit-up-enabled = true;
      rpc-port = 9091;
      rpc-bind-address = "0.0.0.0";
      rpc-host-whitelist-enabled = false;
      rpc-authentication-required = false;
      rpc-whitelist-enabled = false;
    };
  };
}
