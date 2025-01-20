{
  zed,
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = false; # build is broken currently (https://github.com/zed-industries/zed/issues/22098)
    package = zed.packages."${pkgs.system}".default;
  };
}
