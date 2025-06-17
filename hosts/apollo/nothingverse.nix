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

  services.nothingverse = {
    enable = true;
    url = "http://127.0.0.1:5000";
  };
}
