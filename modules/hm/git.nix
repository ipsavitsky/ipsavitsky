{ pkgs, inputs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.git;
      settings = {
        user = {
          name = "Ilya Savitsky";
          email = "ipsavitsky234@gmail.com";
        };
      };
    };

    difftastic = {
      enable = true;
      options.display = "inline";
    };

    mergiraf = {
      enable = true;
      package = inputs.mergiraf.packages.${pkgs.system}.default;
    };

    gh = {
      enable = true;
    };

    gh-dash = {
      enable = true;
    };
  };

  home.packages = [ pkgs.glab ];
}
