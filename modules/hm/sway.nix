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
  shotman_package = inputs.wayland-overlay.packages.${pkgs.system}.shotman;
in
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      menu = pkgs.lib.getExe fuzzel_package;
      terminal = "ghostty";
      bars = [ ];
      keybindings = pkgs.lib.mkOptionDefault {
        "Mod4+l" = "exec ${pkgs.lib.getExe swaylock_package} -d --clock --indicator";
        "Print" = "exec ${pkgs.lib.getExe shotman_package} -c region -C";
        "Shift+Print" = "exec ${pkgs.lib.getExe shotman_package} -c window -C";
        "Ctrl+Shift+Print" = "exec ${pkgs.lib.getExe shotman_package} -c output -C";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "gb,us";
          xkb_options = "grp:win_space_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "enable";
        };
      };
    };
  };

  programs = {
    waybar = {
      enable = true;
      package = waybar_package;
      systemd = {
        enable = true;
        target = "sway-session.target";
      };
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
      systemdTarget = "sway-session.target";
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
    wlsunset = {
      enable = true;
      package = inputs.wayland-overlay.packages."x86_64-linux".wlsunset;
      sunrise = "05:00";
      sunset = "22:00";
    };
  };

  home.packages = [
    inputs.wayland-overlay.packages.${pkgs.system}.wl-clipboard
    inputs.wayland-overlay.packages.${pkgs.system}.wlay
    inputs.wayland-overlay.packages.${pkgs.system}.shotman
  ];
}
