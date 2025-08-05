{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg = {
    enable = true;
    autostart.enable = true;
    mime.enable = true;
    menus.enable = true;
    icons.enable = true;
    sounds.enable = true;

    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland # For Hyprland
        pkgs.xdg-desktop-portal-wlr # For Niri
        pkgs.xdg-desktop-portal-kde # For Plasma
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xdg-utils
  ];

}
