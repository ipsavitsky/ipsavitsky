_:

let
  prometheusPort = 9098;
  pushgatewayPort = 9099;
  grafanaPort = 4000;
in
{
  services.prometheus = {
    enable = true;
    port = prometheusPort;
    globalConfig.scrape_interval = "15s";

    scrapeConfigs = [
      {
        job_name = "pushgateway";
        honor_labels = true;
        static_configs = [ { targets = [ "localhost:${toString pushgatewayPort}" ]; } ];
      }
    ];

    pushgateway = {
      enable = true;
      web.listen-address = ":${toString pushgatewayPort}";
      persistMetrics = true;
      persistence.interval = "5m";
    };
  };

  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "127.0.0.1";
      http_port = grafanaPort;
    };

    provision = {
      enable = true;
      datasources.settings = {
        apiVersion = 1;
        datasources = [
          {
            name = "Prometheus";
            type = "prometheus";
            access = "proxy";
            url = "http://127.0.0.1:${toString prometheusPort}";
            isDefault = true;
          }
        ];
      };
    };
  };
}
