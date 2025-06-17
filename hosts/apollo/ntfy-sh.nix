_: {
  systemd.tmpfiles.rules = [
    "d /var/lib/ntfy-sh/ 0700 ntfy-sh ntfy-sh -"
    "f /var/lib/ntfy-sh/user.db 0700 ntfy-sh ntfy-sh -"
    "f /var/lib/ntfy-sh/cache.db 0700 ntfy-sh ntfy-sh -"
    "d /var/lib/ntfy-sh/attachments 0700 ntfy-sh ntfy-sh -"
  ];

  services.ntfy-sh = {
    enable = true;
    settings = {
      base-url = "https://ntfy.savitsky.dev";
      listen-http = "127.0.0.1:4321";
      auth-file = "/var/lib/ntfy-sh/user.db";
      auth-default-access = "deny-all";
      cache-file = "/var/lib/ntfy-sh/cache.db";
      attachment-cache-dir = "/var/lib/ntfy-sh/attachments";
      enable-login = true;
    };
  };
}
