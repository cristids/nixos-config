{ config, pkgs, ... }:

{

  programs.hyprland = {
        enable = true;
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
        withUWSM = false;
  };
  programs.iio-hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;


  #programs.uwsm.enable = true;
  programs.waybar = {
        enable = false;
  #      package = pkgs.waybar-hyprland;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
        kitty
        xdg-desktop-portal-hyprland
#        kanshi
        networkmanagerapplet
        
  ];


}