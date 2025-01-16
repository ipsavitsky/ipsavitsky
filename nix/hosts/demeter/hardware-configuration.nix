{
  ...
}:
{
  raspberry-pi-nix.board = "bcm2712"; # this is raspberry pi 5

  hardware = {
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

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/31c1a1fe-90b1-4f12-b55c-69be3a0bcbc3";
    fsType = "btrfs";
  };
}
