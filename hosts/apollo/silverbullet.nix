{
  pkgs,
  inputs,
  config,
  ...
}:
{
  sops.secrets."silverbullet/environment" = {
    owner = "silverbullet";
  };

  services.silverbullet =
    let
      unstable_pkgs = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
    in
    {
      enable = true;
      package = unstable_pkgs.silverbullet;
      envFile = config.sops.secrets."silverbullet/environment".path;
    };
}
