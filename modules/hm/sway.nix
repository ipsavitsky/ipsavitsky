{
  pkgs,
  lib,
  inputs,
  config,
  upper_config,
  ...
}:
let
  fuzzel_package = pkgs.fuzzel;
  waybar_package = inputs.waybar.packages.${pkgs.system}.default;
  swaylock_package = inputs.wayland-overlay.packages.${pkgs.system}.swaylock-effects;
  swaylock_config = "${lib.getExe swaylock_package} --clock --indicator";
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
      menu = lib.getExe fuzzel_package;
      terminal = "ghostty";
      bars = [ ];
      keybindings = lib.mkOptionDefault {
        "Mod4+l" = "exec ${swaylock_config}";
        "Print" = "exec ${lib.getExe' shotman_package "shotman"} -c region -C";
        "Shift+Print" = "exec ${lib.getExe' shotman_package "shotman"} -c window -C";
        "Ctrl+Shift+Print" = "exec ${lib.getExe' shotman_package "shotman"} -c output -C";
        "Mod4+P" = "exec ${lib.getExe' shotman_package "shotman"} -c region -C";
        "Mod4+Shift+P" = "exec ${lib.getExe' shotman_package "shotman"} -c window -C";
        "Mod4+Ctrl+Shift+P" = "exec ${lib.getExe' shotman_package "shotman"} -c output -C";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "gb,us,ru";
          xkb_options = "grp:win_space_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "enable";
        };
      };
    };
  };

  stylix.targets = {
    waybar = {
      font = "sansSerif";
      addCss = false;
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
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 35;
          modules-left = [
            "sway/workspaces"
            "sway/mode"
          ];
          modules-center = [ "sway/window" ];
          modules-right = [
            "pulseaudio/slider"
            "sway/language"
            "cpu"
            # "memory"
            "battery"
            "disk"
            "clock"
          ];

          "sway/window" = {
            swap-icon-label = true;
          };

          "pulseaudio/slider" = {
            min = 0;
            max = 100;
            orientation = "horizontal";
          };

          "sway/language" = {
            format = "{shortDescription}:{short}";
          };

          "sway/workspaces" = {
            sort-by-number = true;
            disable-scroll = true;
          };

          cpu = {
            format = "cpu:{usage}%";
          };

          # this breaks waybar???
          # memory = {
          #   format = "mem:{usage}%";
          # };

          battery = {
            format = "bat:{capacity}%";
          };

          disk = {
            format = "disk:{percentage_used}% ({used}/{total})";
          };

          clock = {
            format = "{:%H:%M %d/%m}";
          };
        };
      };

      style = lib.mkAfter (builtins.readFile ./waybar-confs/style.css);
    };

    fuzzel = {
      enable = true;
      package = fuzzel_package;
    };

    swaylock = {
      enable = true;
      package = swaylock_package;
      settings = {
        font = config.stylix.fonts.sansSerif.name;
      };
    };
  };

  services = {
    mako = {
      enable = true;
      package = inputs.wayland-overlay.packages.${pkgs.system}.mako;
      settings = {
        actions = true;
        icons = true;
        ignore-timeout = false;
        markup = true;
      };
    };
    swayidle = {
      package = inputs.wayland-overlay.packages.${pkgs.system}.swayidle;
      systemdTarget = "sway-session.target";
      enable = true;
      extraArgs = [ "-d" ];
      timeouts =
        let
          swaymsg-pkg = lib.getExe' upper_config.programs.sway.package "swaymsg";
          lock-timeout = 5 * 60;
        in
        [
          {
            timeout = lock-timeout;
            command = swaylock_config;
          }
          {
            timeout = lock-timeout + 20;
            command = "${swaymsg-pkg} 'output * dpms off'";
            resumeCommand = "${swaymsg-pkg} 'output * dpms on'";
          }
        ];
    };
    wlsunset = {
      enable = true;
      package = inputs.wayland-overlay.packages.${pkgs.system}.wlsunset;
      sunrise = "05:00";
      sunset = "22:00";
    };
  };

  home.pointerCursor = {
    name = "Simp1e";
    package = pkgs.simp1e-cursors;
    # size = 24;
  };

  home.packages = [
    inputs.wayland-overlay.packages.${pkgs.system}.wl-clipboard
    inputs.wayland-overlay.packages.${pkgs.system}.wlay
    inputs.wayland-overlay.packages.${pkgs.system}.shotman
  ];
}
