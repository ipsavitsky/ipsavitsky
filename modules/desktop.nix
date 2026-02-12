{ pkgs, inputs, ... }:
{
  programs.sway = {
    enable = true;
    package = pkgs.sway;
    wrapperFeatures.gtk = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    extraPackages = [ ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    xdgOpenUsePortal = false;
    config = {
      preferred = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gnome" ];
      };
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "nvidia-x11"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcublas"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "libnpp"
      "nvidia-settings"

      "spotify"
      "terraform"
    ];

  services = {
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver.videoDrivers = [ "nvidia" ];
    displayManager.ly.enable = true;
    blueman.enable = true;
    ollama = {
      acceleration = "cuda";
    };
    flatpak.enable = true;
    printing.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  environment.systemPackages =
    with pkgs;
    with inputs;
    [
      blueman
      telegram-desktop
      spotify
      gparted
      nmap
      transmission_4-qt
    ];
}
