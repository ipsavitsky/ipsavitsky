_: {
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "**/.terraform.lock.hcl" # no formatting the lock file!
    "secrets/demeter.yaml" # no formatting the generate
    "*.el" # no formatters available for those styles
    "*.org"
  ];
  programs = {
    nixfmt.enable = true;
    shfmt.enable = true;
    terraform.enable = true;
    actionlint.enable = true;
    yamlfmt.enable = true;
    just.enable = true;
  };
}
