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
        enable = true;
        package = pkgs.waybar-hyprland;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
#   environment.systemPackages = with pkgs; [
#         kitty
#         xdg-desktop-portal-hyprland
# #        kanshi
#         networkmanagerapplet
        
#   ];


  # programs.hyprland.config = {
  #   # Set the wallpaper
  #   #wallpaper = "path/to/your/wallpaper.jpg";

  #   # Set the theme
  #   #theme = "path/to/your/theme";

  #   # Enable compositor
  #   compositor.enable = true;

  #   # Enable touchpad gestures
  #   touchpadGestures.enable = true;

  #   # Enable notifications
  #   notifications.enable = true;

  #   # Enable window management
  #   windowManagement.enable = true;

  #   # Enable custom keybindings
  #   keybindings.enable = true;
  # };
  }