{ config, ... }:
{
  services.ddclient = {
    enable = false;
    configFile = config.sops.secrets."ddclient/ddclient.conf".path;
  };

  sops.secrets."ddclient/ddclient.conf" = { };
}
