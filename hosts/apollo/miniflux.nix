{ config, lib, ... }:
{
  sops.secrets."miniflux/admin_creds.sh" = {
    owner = "miniflux";
  };

  services.miniflux = {
    enable = true;
    config = {
      LISTEN_ADDR = "127.0.0.1:5678";
    };
    adminCredentialsFile = config.sops.secrets."miniflux/admin_creds.sh".path;
  };

  users.users.miniflux = {
    name = "miniflux";
    group = "miniflux";
    isSystemUser = true;
  };
  users.groups.miniflux = { };

  systemd.services = {
    miniflux = {
      after = [ "postgresql.service" ];
      serviceConfig = {
        DynamicUser = lib.mkForce false;
        Group = lib.mkForce "miniflux";
        User = lib.mkForce "miniflux";
      };
    };
  };
}
