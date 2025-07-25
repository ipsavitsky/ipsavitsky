{ pkgs, inputs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "Ilya Savitsky";
    userEmail = "ipsavitsky234@gmail.com";

    difftastic = {
      enable = true;
      display = "inline";
    };
  };

  programs.mergiraf = {
    enable = true;
    package = inputs.mergiraf.packages.${pkgs.system}.default;
  };
}
