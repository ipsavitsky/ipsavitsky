{
  pkgs,
  inputs,
  config,
  ...
}:
{
  programs.halloy =
    let
      unstable_pkgs = import inputs.nixpkgs-unstable { system = pkgs.system; };
    in
    {
      enable = true;
      package = unstable_pkgs.halloy;
      settings = {
        servers.soju = {
          nickname = "ilya";
          server = "irc.savitsky.dev";
          port = 6697;
          sasl.plain = {
            username = "ilya";
            password_file = config.sops.secrets."irc/soju_password".path;
          };
        };

        buffer.chathistory.infinite_scroll = true;

        actions = {
          sidebar = {
            buffer = "replace-pane";
            focused_buffer = "close-pane";
          };
          buffer = {
            click_channel_name = "new-pane";
            click_username = "new-pane";
          };
        };
      };
    };

  sops.secrets."irc/soju_password" = {
    sopsFile = ../../secrets/hm.yaml;
  };
}
