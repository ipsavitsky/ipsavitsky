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
            alias = "leftIiyama";
            criteria = "Iiyama North America PL2792Q 1226242811255";
            mode = "2560x1440@59.951Hz";
            position = "0,0";
          };
        }
        {
          output = {
            alias = "rightIiyama";
            criteria = "Iiyama North America PL2792Q 1226242811257";
            mode = "2560x1440@59.951Hz";
            position = "2560,0";
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
                criteria = "$leftIiyama";
                position = "0,0";
                status = "enable";
              }
              {
                criteria = "$rightIiyama";
                position = "2560,0";
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
