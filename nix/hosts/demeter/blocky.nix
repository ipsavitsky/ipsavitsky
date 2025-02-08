{ config, ... }:
{
  services = {
    blocky = {
      enable = false;
      settings = {
        ports.dns = 53; # Port for incoming DNS Queries.
        upstreams.groups.default = [
          "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
        ];
        # For initially solving DoH/DoT Requests when no system Resolver is available.
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = [
            "1.1.1.1"
            "1.0.0.1"
          ];
        };
        #Enable Blocking of certain domains.
        blocking = {
          denylists = {
            #Adblocking
            ads = [ "https://blocklistproject.github.io/Lists/ads.txt" ];
          };
          #Configure what block categories are used
          clientGroupsBlock = {
            default = [ "ads" ];
          };
        };
      };
    };
  };
}
