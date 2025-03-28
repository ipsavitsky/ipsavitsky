{ nothingverse, ... }:
{
  imports = [
    nothingverse.nixosModules.nothingverse
  ];

  services.ollama.enable = true;

  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.nothingverse = {
    enable = true;
    dataDir = "/data/nothingverse";
  };
}
