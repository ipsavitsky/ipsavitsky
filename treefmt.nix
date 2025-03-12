_: {
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "**/.terraform.lock.hcl" # no formatting the lock file!
  ];
  programs = {
    nixfmt.enable = true;
    shfmt.enable = true;
    terraform.enable = true;
    # actionlint.enable = true;
    # yamlfmt.enable = true;
  };
}
