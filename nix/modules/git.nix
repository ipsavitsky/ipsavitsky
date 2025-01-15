{ pkgs, ... }:
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
}
