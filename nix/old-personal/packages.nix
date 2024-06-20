{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # Desktop apps
    alacritty
    obs-studio
    discord
    gparted
    firefox
    thunderbird
    quassel

    # Sound
    pipewire
    pulseaudio
    pamixer
  ];
}
