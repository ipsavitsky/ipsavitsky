{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    tree
    cloc
    xclip
    fd
    file

    home-manager
  ];

  fonts.packages = with pkgs; [
    fira-code
    emacs-all-the-icons-fonts
  ];

  home-manager = {
    users.ilya = ./home-manager/home.nix;
    useGlobalPkgs = true;
  };
}
