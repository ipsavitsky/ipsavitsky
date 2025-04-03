{ nothingverse, ... }:
{
  imports = [
    nothingverse.nixosModules.nothingverse
  ];

  systemd.tmpfiles.rules = [
    "d /data/ollama 0700 ollama ollama -"
  ];

  services.ollama = {
    enable = true;
    user = "ollama";
    group = "ollama";
    home = "/data/ollama";
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.nothingverse = {
    enable = true;
    dataDir = "/data/nothingverse";
  };
}
