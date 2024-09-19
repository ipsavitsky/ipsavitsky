{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tree
    cloc
    xclip
    fd
    file

    home-manager
  ];
  
  home-manager = {
    users.ilya = ./home-manager/home.nix;
    useGlobalPkgs = true;
  };

  fonts.packages = with pkgs; [
    fira-code
  ];
}
