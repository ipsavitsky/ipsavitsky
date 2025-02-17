{
  zed,
  pkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    package = zed.packages."${pkgs.system}".default;
  };
}
