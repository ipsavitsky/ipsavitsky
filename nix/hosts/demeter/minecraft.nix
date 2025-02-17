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

  systemd.tmpfiles.rules = [
    "d /data/minecraft 0700 minecraft minecraft -"
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    dataDir = "/data/minecraft";
    servers.fabric = {
      enable = true;
      jvmOpts = "-Xmx4G -Xms2G";

      package = pkgs.minecraftServers.fabric-1_21_4;
    };
  };
}
