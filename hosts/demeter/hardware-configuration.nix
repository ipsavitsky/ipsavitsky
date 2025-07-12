_: {
  raspberry-pi-nix.board = "bcm2712"; # this is raspberry pi 5

  hardware = {
    graphics.enable = true;

    raspberry-pi = {
      config = {
        all = {
          options = {
            camera_auto_detect = {
              enable = true;
              value = 0;
            };
            display_auto_detect = {
              enable = true;
              value = 0;
            };
          };
          base-dt-params = {
            pciex3 = {
              enable = true;
            };
            pciex1_gen = {
              enable = true;
              value = 3;
            };
          };
        };
      };
    };
  };

  services.getty.autologinUser = "root";
}
