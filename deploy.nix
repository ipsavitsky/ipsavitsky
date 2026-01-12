{ self, deploy-rs }:
{
  deploy.nodes = {
    helios = {
      hostname = "65.21.157.195";
      sshUser = "root";
      user = "root";
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.helios;
    };
    apollo = {
      hostname = "192.168.55.103";
      sshUser = "ilya";
      user = "root";
      profiles.system.path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.apollo;
    };
  };

  checks = builtins.mapAttrs (_system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
}
