{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg = {
    autostart.enable = true;
    mime.enable = true;
    menus.enable = true;
    icons.enable = true;
    sounds.enable = true;

    portal = {
      enable = true;
      #wlr.enable = false; # Enable wlr portal for wlroots-based compositors like Niri
      extraPortals = [
        #  #pkgs.xdg-desktop-portal-wlr # For Niri
        #pkgs.xdg-desktop-portal-hyprland # For Hyprland
        #pkgs.kdePackages.xdg-desktop-portal-kde # For KDE
        #  # pkgs.xdg-desktop-portal-gtk
        #  # pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-cosmic
      ];
      xdgOpenUsePortal = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-user-dirs
    # Portal packages needed for screen capture
    #xdg-desktop-portal # Base portal service
    #xdg-desktop-portal-gtk
    #xdg-desktop-portal-gnome
    #xdg-desktop-portal-wlr
    #xdg-desktop-portal-hyprland
    #kdePackages.xdg-desktop-portal-kde
  ];

}
