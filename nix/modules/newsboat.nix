_: {
  programs.newsboat = {
    enable = true;
    # newsboat package option does not exist :(
    # package = pkgs.newsboat;
    urls = [
      {
        title = "xkcd";
        url = "https://xkcd.com/rss.xml";
      }
      {
        title = "rust";
        url = "https://blog.rust-lang.org/feed.xml";
      }
      {
        title = "codethink";
        url = "https://social.codethink.co.uk/@codethink.rss";
      }
    ];
  };
}
