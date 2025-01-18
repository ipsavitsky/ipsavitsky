{ config, ... }:
{
  services.ddclient = {
    enable = true;
    configFile = config.sops.secrets."ddclient/ddclient.conf".path;
  };

  sops.secrets."ddclient/ddclient.conf" = { };
}
