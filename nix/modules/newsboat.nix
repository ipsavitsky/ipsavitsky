_: {
  programs.newsboat = {
    enable = true;
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
      {
        title = "The Register | Software";
        url = "https://www.theregister.com/software/headlines.atom";
      }
      {
        title = "RBC";
        url = "https://rssexport.rbc.ru/rbcnews/news/30/full.rss";
      }
      {
        title = "WIRED | Top stories";
        url = "https://www.wired.com/feed/rss";
      }
    ];
  };
}
