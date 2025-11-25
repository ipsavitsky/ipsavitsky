_: {
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "secrets/*.yaml" # no formatting the generates
    "*.el" # no formatters available for those styles
    "*.org"
  ];
  programs = {
    nixfmt.enable = true;
    shfmt.enable = true;
    actionlint.enable = true;
    yamlfmt.enable = true;
    just.enable = true;
    deadnix.enable = true;
    statix.enable = true;
    zizmor.enable = true;
  };
}
