{
  zed,
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = false;
    package = zed.packages."${pkgs.system}".default;
  };
}
