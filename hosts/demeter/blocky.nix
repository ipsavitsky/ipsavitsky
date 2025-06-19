_: {
  services.blocky = {
    enable = true;
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
      #Enable blocking of certain domains.
      blocking = {
        blackLists = {
          #Adblocking
          ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
    };
  };
}
