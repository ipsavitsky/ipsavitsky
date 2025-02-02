{ pkgs, savitsky-dev, ... }:
{
  services = {
    cloudflared = {
      enable = false;
      tunnels = {
        "fill-in-this-tunnel-id" = {
          ingress = {
            "savitsky.dev" = {
              path = "${savitsky-dev.packages.${pkgs.system}.default}/static";
            };
          };
        };
      };
    };
  };
}
