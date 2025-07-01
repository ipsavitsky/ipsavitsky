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
      keybindings = {
        # "Mod4+0" = "workspace number 10";
        # "Mod4+1" = "workspace number 1";
        # "Mod4+2" = "workspace number 2";
        # "Mod4+3" = "workspace number 3";
        # "Mod4+4" = "workspace number 4";
        # "Mod4+5" = "workspace number 5";
        # "Mod4+6" = "workspace number 6";
        # "Mod4+7" = "workspace number 7";
        # "Mod4+8" = "workspace number 8";
        # "Mod4+9" = "workspace number 9";
        # "Mod4+0" = "workspace number 10";
        # "Mod4+Shift+1" = "move container to workspace number 1";
        # "Mod4+Shift+2" = "move container to workspace number 2";
        # "Mod4+Shift+3" = "move container to workspace number 3";
        # "Mod4+Shift+4" = "move container to workspace number 4";
        # "Mod4+Shift+5" = "move container to workspace number 5";
        # "Mod4+Shift+6" = "move container to workspace number 6";
        # "Mod4+Shift+7" = "move container to workspace number 7";
        # "Mod4+Shift+8" = "move container to workspace number 8";
        # "Mod4+Shift+9" = "move container to workspace number 9";
        "Mod4+Left" = "focus left";
        "Mod4+Right" = "focus right";
        "Mod4+Up" = "focus up";
        "Mod4+Down" = "focus down";
        "Mod4+Shift+Left" = "move left";
        "Mod4+Shift+Right" = "move right";
        "Mod4+Shift+Up" = "move up";
        "Mod4+Shift+Down" = "move down";
        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+q" = "kill";
        "Mod4+Shift+Space" = "floating toggle";
        "Mod4+w" = "layout tabbed";
        "Mod4+e" = "layout toggle split";
        "Mod4+l" = "exec ${pkgs.lib.getExe swaylock_package} -d --clock --indicator";
        "Print" = "exec ${pkgs.lib.getExe' shotman_package "shotman"} -c region -C";
        "Shift+Print" = "exec ${pkgs.lib.getExe' shotman_package "shotman"} -c window -C";
        "Ctrl+Shift+Print" = "exec ${pkgs.lib.getExe' shotman_package "shotman"} -c output -C";
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
