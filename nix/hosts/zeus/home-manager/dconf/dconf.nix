# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/blueman/general" = {
      window-properties = [ 1555 1133 686 634 ];
    };

    "org/blueman/plugins/autoconnect" = {
      services = [ (mkTuple [ "/org/bluez/hci0/dev_D6_45_83_91_E1_DE" "00000000-0000-0000-0000-000000000000" ]) ];
    };

    # "org/blueman/plugins/recentconns" = {
    #   recent-connections = [ {
    #     adapter = "C8:5E:A9:C3:15:35";
    #     address = "D6:45:83:91:E1:DE";
    #     alias = "Glove80";
    #     icon = "input-keyboard";
    #     name = "Audio and input profiles";
    #     uuid = "00000000-0000-0000-0000-000000000000";
    #     time = "1731911283.8409667";
    #   } ];
    # };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 152;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 26 23 ];
      window-size = mkTuple [ 1124 822 ];
    };

  };
}
