{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    zellij
    
    # Other
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
