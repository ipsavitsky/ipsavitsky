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
    enable = false;
    eula = true;
    openFirewall = true;
    dataDir = "/data/minecraft";
    servers.fabric = {
      enable = true;
      # Xmx is the maximum heap size
      # Xms is the minimum heap size
      jvmOpts = "-Xmx2G -Xms128mb";

      package = pkgs.minecraftServers.fabric-1_21_4;
    };
  };
}
