{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home = {
    username = "ilya";
    homeDirectory = "/home/ilya";

    packages =
      with pkgs;
      with inputs;
      [
        yubikey-manager
        quasselClient

        charmbracelet-nur.packages.${pkgs.system}.vhs
        charmbracelet-nur.packages.${pkgs.system}.gum
        nom.packages.${pkgs.system}.default
        statix.packages.${pkgs.system}.default
        deadnix.packages.${pkgs.system}.default
      ];
  };

  programs.git.userEmail = lib.mkForce "ilya.savitsky@codethink.co.uk";

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adawita";
    };
  };

  services = {
    kanshi = {
      enable = true;
      package = inputs.wayland-overlay.packages.${pkgs.system}.kanshi;
      systemdTarget = "sway-session.target";
      settings = [
        {
          output = {
            alias = "builtinMonitor";
            criteria = "eDP-1";
            mode = "1920x1200@60.001Hz";
            position = "0,0";
          };
        }
        {
          output = {
            alias = "leftPhillips";
            criteria = "Philips Consumer Electronics Company PHL 243V5 UK01750002520";
            mode = "1920x1080@60Hz";
            position = "0,0";
          };
        }
        {
          output = {
            alias = "rightPhillips";
            criteria = "Philips Consumer Electronics Company PHL 243V5 UK01750002509";
            mode = "1920x1080@60Hz";
            position = "1080,0";
          };
        }
        {
          profile = {
            name = "default";
            outputs = [
              {
                criteria = "$builtinMonitor";
                status = "enable";
              }
            ];
          };
        }
        {
          profile = {
            name = "docked";
            outputs = [
              {
                criteria = "$builtinMonitor";
                status = "disable";
              }
              {
                criteria = "$leftPhillips";
                position = "0,0";
                status = "enable";
              }
              {
                criteria = "$rightPhillips";
                position = "1920,0";
                status = "enable";
              }
            ];
          };
        }
      ];
    };
  };

  programs = {
    k9s = {
      enable = true;
      package = pkgs.k9s;
    };
  };
}
