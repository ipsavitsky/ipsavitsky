{
  inputs,
  ...
}:
{
  imports = [
    inputs.network-master-server.nixosModules.network-master-server
  ];

  services.network-master-server.enable = true;
}
