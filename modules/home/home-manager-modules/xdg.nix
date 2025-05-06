{pkgs, ...}: {
  xdg = {
    enable = true;
    autostart.enable = true;
    mime.enable = true;
    #menus.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      configPackages = [pkgs.hyprland];
    };
  };
}
