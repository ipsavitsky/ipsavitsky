{ inputs, ... }:
{
  imports = [
    inputs.nothingverse.nixosModules.nothingverse
  ];

  services.ollama = {
    enable = true;
    user = "ollama";
    group = "ollama";
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];

  services.nothingverse = {
    enable = true;
    url = "http://0.0.0.0:5000";
  };
}
