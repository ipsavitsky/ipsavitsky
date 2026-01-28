{ inputs, ... }:
{
  imports = [
    inputs.interlinked.nixosModules.interlinked
  ];

  services.interlinked = {
    enable = true;
    address = "localhost:4567";
    url = "https://itlkd.savitsky.dev";
  };
}
