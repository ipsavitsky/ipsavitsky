{ ... }:
{
  dconf = {
    enable = true;
    settings= {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/settings-daemon.plugins.housekeeping" = {
        active = false;
      };
    };
  };
}
