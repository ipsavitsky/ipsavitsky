{ inputs, config, ... }:
{
  imports = [
    inputs.interval-cards-bot.nixosModules.interval-cards-bot
  ];

  sops.secrets = {
    "interval-cards-bot/token" = {
      owner = "interval-cards-bot";
    };
  };

  services.interval-cards-bot = {
    enable = true;
    webPort = 8080;
    webappUrl = "https://cards.savitsky.dev";
  };

  systemd.services.interval-cards-bot.serviceConfig.EnvironmentFile =
    config.sops.secrets."interval-cards-bot/token".path;
}
