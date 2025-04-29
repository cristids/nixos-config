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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    uwsm
    kitty
    xdg-desktop-portal-hyprland
    networkmanagerapplet
  ];
}
