{ pkgs, lib, inputs, ... }:
{
  systemd.tmpfiles.rules = [
    "d /data/open-webui 0700 open-webui open-webui -"
  ];

  users.users.open-webui = {
    name = "open-webui";
    group = "open-webui";
    isSystemUser = true;
  };
  users.groups.open-webui = { };

  services.open-webui =
  let
    pkgs_unstable = import inputs.nixpkgs-unstable {
      inherit (pkgs) system;
      config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "open-webui" ];
    };
  in
  {
    enable = true;
    package = pkgs_unstable.open-webui;
    stateDir = "/data/open-webui";
    port = 9568;
  };

  systemd.services.open-webui = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      Group = lib.mkForce "open-webui";
      User = lib.mkForce "open-webui";
    };
  };
}
