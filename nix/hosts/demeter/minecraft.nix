{ nix-minecraft, pkgs, lib, ... }:
{
  imports = [
    nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs = {
    overlays = [
      nix-minecraft.overlay
    ];
    config = {
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "minecraft-server"
        ];
    };
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.vanilla = {
      enable = true;
      jvmOpts = "-Xmx4G -Xms2G";

      package = pkgs.minecraftServers.fabric-1_21_4;
    };
  };
}
