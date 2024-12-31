{ ... }:
{
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "**/.terraform.lock.hcl" # no formatting the lock file!
  ];
  # programs.actionlint.enable = true;
  programs.nixfmt.enable = true;
  # programs.yamlfmt.enable = true;
  programs.shfmt.enable = true;
  programs.terraform.enable = true;
}
