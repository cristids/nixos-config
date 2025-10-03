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

    portal = {
      enable = true;
      extraPortals = [
        # pkgs.xdg-desktop-portal-wlr # For Niri
        pkgs.xdg-desktop-portal-hyprland # For Hyprland
        # pkgs.kdePackages.xdg-desktop-portal-kde # For KDE
        # pkgs.xdg-desktop-portal-gtk
        # pkgs.xdg-desktop-portal-gnome
        # pkgs.xdg-desktop-portal-cosmic
      ];
      xdgOpenUsePortal = true;
    };
  };
}
