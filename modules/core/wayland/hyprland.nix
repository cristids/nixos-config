{
  config,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
  programs.iio-hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  programs.uwsm.enable = true;

  xdg = {
    # enable = true;
    autostart.enable = true;
    mime.enable = true;
    menus.enable = true;
    icons.enable = true;
    sounds.enable = true;
    #mimeApps = {
    #  enable = true;
    #};
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-hyprland];
      configPackages = [pkgs.hyprland];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    uwsm
    kitty
    alacritty
    xdg-desktop-portal-hyprland
    networkmanagerapplet
    xdg-utils
  ];
}
