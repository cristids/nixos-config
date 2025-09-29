{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };
  #programs.iio-hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  programs.uwsm.enable = false;
  #programs.uwsm.waylandCompositors.hyprland = {
  #  prettyName = "Hyprland";
  #  comment = "Hyprland compositor managed by UWSM";
  #  binPath = "/run/current-system/sw/bin/Hyprland";
  #};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #uwsm
    #kitty
    #alacritty
    networkmanagerapplet
    libsForQt5.qt5ct
  ];
}
