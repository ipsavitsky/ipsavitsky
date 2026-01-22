{ pkgs, config, ... }:
{
  sops.secrets."renovate/github_com" = { };
  services.renovate = {
    enable = true;
    schedule = "weekly";
    validateSettings = true;
    runtimePackages = with pkgs; [
      go
      cargo
      rustc
      uv
      python3
      config.nix.package
      git
      openssh
      bash
    ];
    settings = {
      autodiscover = true;
      autodiscoverTopics = [ "managed-by-renovate" ];
      labels = [
        "dependencies"
        "renovate"
      ];
      nix.enabled = true;
      lockFileMaintenance.enabled = true;
      username = "Ilya's renovate bot";
      gitAuthor = "Ilya's renovate bot <renovate@savitsky.invalid>";
      allowedCommands = [
        "^go mod tidy$"
        "^bash ./scripts/vendor_hash.sh --update$"
      ];
      prConcurrentLimit = 0;
      prHourlyLimit = 0;
      separateMajorMinor = false;
      packageRules = [
        {
          matchDepNames = [ "nixpkgs" ];
          enabled = false;
        }
        {
          groupName = "all dependencies";
          matchPackageNames = [ "*" ];
        }
      ];
    };
    credentials = {
      RENOVATE_TOKEN = config.sops.secrets."renovate/github_com".path;
    };
  };
}
