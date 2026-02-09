{ config, ... }:
let
  domain = "matrix.savitsky.dev";
  port = 8008;
in
{
  sops.secrets."tuwunel/token" = {
    owner = "tuwunel";
  };

  services.caddy = {
    enable = true;

    email = "ilya@savitsky.dev";

    virtualHosts."${domain}" = {
      extraConfig = ''
        handle_path /.well-known/matrix/server {
          header Access-Control-Allow-Origin *
          respond `{"m.server": "${domain}:443"}` 200
        }

        handle_path /.well-known/matrix/client {
          header Access-Control-Allow-Origin *
          header Content-Type application/json
          respond `${
            builtins.toJSON {
              "m.homeserver" = {
                base_url = "https://${domain}";
              };
            }
          }` 200
        }

        handle /_matrix/* {
          reverse_proxy 127.0.0.1:${toString port}
        }
      '';
    };
  };

  services.matrix-tuwunel = {
    enable = true;
    # stateDirectory = "/data/tuwunel";
    settings.global = {
      server_name = domain;
      trusted_servers = [ "matrix.org" ];

      address = [ "127.0.0.1" ];
      port = [ port ];

      max_request_size = 20000000;
      zstd_compression = false;
      gzip_compression = false;
      brotli_compression = false;

      ip_range_denylist = [
        "127.0.0.0/8"
        "10.0.0.0/8"
        "172.16.0.0/12"
        "192.168.0.0/16"
        "100.64.0.0/10"
        "192.0.0.0/24"
        "169.254.0.0/16"
        "192.88.99.0/24"
        "198.18.0.0/15"
        "192.0.2.0/24"
        "198.51.100.0/24"
        "203.0.113.0/24"
        "224.0.0.0/4"
        "::1/128"
        "fe80::/10"
        "fc00::/7"
        "2001:db8::/32"
        "ff00::/8"
        "fec0::/10"
      ];

      allow_legacy_media = false;
      allow_guest_registration = false;
      log_guest_registrations = false;
      allow_guests_auto_join_rooms = false;
      allow_registration = true;
      registration_token_file = config.sops.secrets."tuwunel/token".path;
      # yes_i_am_very_very_sure_i_want_an_open_registration_server_prone_to_abuse = true;
      allow_federation = true;
      allow_public_room_directory_over_federation = false;
      allow_public_room_directory_without_auth = false;
      lockdown_public_room_directory = false;
      allow_device_name_federation = false;
      url_preview_domain_contains_allowlist = [ ];
      url_preview_domain_explicit_allowlist = [ ];
      url_preview_url_contains_allowlist = [ ];
      url_preview_domain_explicit_denylist = [ ];
      url_preview_max_spider_size = 384000;
      url_preview_check_root_domain = false;
      allow_profile_lookup_federation_requests = true;

      log = "debug";
      new_user_displayname_suffix = "";

      cache_capacity_modifier = 1.2;
      db_cache_capacity_mb = 64.0;
      db_write_buffer_capacity_mb = 24.0;
      dns_cache_entries = 4096;
      stream_width_scale = 0.5;
      stream_amplification = 256;
      stream_width_default = 16;
      db_pool_workers = 8;

      allow_local_presence = false;
      allow_incoming_presence = false;
      allow_outgoing_presence = false;
    };

    settings.well_known = {
      client = "https://${domain}";
      server = "${domain}:443";
    };
  };

  users.users.tuwunel = {
    name = "tuwunel";
    group = "tuwunel";
    isSystemUser = true;
  };
  users.groups.tuwunel = { };
}
