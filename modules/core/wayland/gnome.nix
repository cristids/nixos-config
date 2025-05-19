{
  pkgs,
  config,
  ...
}: {
  
  services.xserver.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}