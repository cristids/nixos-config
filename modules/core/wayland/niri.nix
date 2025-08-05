#Kudos to https://vlaci.github.io/nix.org/posts/niri
#
#System level niri for nixos. The rest is defined at home level
{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  programs.niri = {
    enable = true;
    #package = inputs.niri.packages.${pkgs.system}.niri-unstable;
    #package = pkgs.niri-stable; #package from overlay above
    package = pkgs.niri-stable; # package from overlay above
  };

  #systemd.user.targets.niri-session.wants = [ "xdg-desktop-autostart.target" ];
  # systemd.user.targets."niri-session" = {
  #   description = "User target for Niri session";
  #   wants = [
  #     "xdg-desktop-portal-wlr.service"
  #     "xdg-desktop-autostart.target"
  #   ];
  #   after = [ "graphical-session.target" ];
  # };

  services.dbus.packages = [ pkgs.nautilus ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    libsecret
    cage
    gamescope
    xwayland-satellite-unstable
    alacritty
    networkmanagerapplet
    libsForQt5.qt5ct
  ];
}
