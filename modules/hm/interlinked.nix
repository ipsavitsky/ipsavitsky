{ inputs, ... }:
{
  imports = [ inputs.interlinked.homeManagerModules.interlinked ];

  programs.interlinked = {
    enable = true;
    settings = {
      backend_url = "https://itlkd.savitsky.dev";
    };
  };
}
