{
  pkgs,
  inputs,
  upper_config,
  ...
}:
let
  fuzzel_package = pkgs.fuzzel;
  waybar_package = inputs.waybar.packages."x86_64-linux".default;
  swaylock_package = inputs.wayland-overlay.packages."x86_64-linux".swaylock-effects;
in
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      menu = pkgs.lib.getExe fuzzel_package;
      terminal = "ghostty";
      bars = [ { command = pkgs.lib.getExe waybar_package; } ];
      keybindings = pkgs.lib.mkOptionDefault {
        "Mod4+l" = "exec ${pkgs.lib.getExe swaylock_package} -d --clock --indicator";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "gb,us";
          xkb_options = "grp:win_space_toggle";
        };
      };
    };
  };

  programs = {
    waybar = {
      enable = true;
      package = waybar_package;
    };
    fuzzel = {
      enable = true;
      package = fuzzel_package;
    };
    swaylock = {
      enable = true;
      package = swaylock_package;
    };
  };

  services = {
    mako = {
      enable = true;
      package = inputs.wayland-overlay.packages."x86_64-linux".mako;
      settings = {
        actions = true;
        icons = true;
        ignore-timeout = false;
        # default-timeout = 10 * 1000;
        markup = true;
      };
    };
    swayidle = {
      package = inputs.wayland-overlay.packages."x86_64-linux".swayidle;
      enable = true;
      extraArgs = [ "-d" ];
      timeouts =
        let
          swaylock-pkg = pkgs.lib.getExe swaylock_package;
          swaymsg-pkg = pkgs.lib.getExe' upper_config.programs.sway.package "swaymsg";
          lock-timout = 5 * 60;
        in
        [
          {
            timeout = lock-timout;
            command = "${swaylock-pkg} -d --clock --indicator";
          }
          {
            timeout = lock-timout + 20;
            command = "${swaymsg-pkg} 'output * dpms off'";
            resumeCommand = "${swaymsg-pkg} 'output * dpms on'";
          }
        ];
    };
  };
}
