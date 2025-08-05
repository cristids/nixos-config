{
  config,
  pkgs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  #programs.iio-hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  programs.uwsm.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    uwsm
    kitty
    alacritty
    networkmanagerapplet
    libsForQt5.qt5ct
  ];
}
