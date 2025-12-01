{ pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    settings = {
      user = {
        name = "Ilya Savitsky";
        email = "ipsavitsky234@gmail.com";
      };
    };
  };

  programs.difftastic = {
    enable = true;
    options.display = "inline";
  };

  programs.mergiraf = {
    enable = true;
    package = inputs.mergiraf.packages.${pkgs.system}.default;
  };
}
