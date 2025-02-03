{
  pkgs,
  savitsky-dev,
  config,
  ...
}:
{
  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "c84429bc-7836-4a8a-9335-21a3d9ce950a" = {
          credentialsFile = config.sops.secrets."cloudflared/c84429bc-7836-4a8a-9335-21a3d9ce950a.json".path;
          default = "http_status:404";
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8410 ];

  sops.secrets."cloudflared/c84429bc-7836-4a8a-9335-21a3d9ce950a.json" = {
    owner = "cloudflared";
  };
}
