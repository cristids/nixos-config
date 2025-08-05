#Kudos to https://vlaci.github.io/nix.org/posts/niri
#
#System level niri for nixos. The rest is defined at home level
{
  pkgs,
  inputs,
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
    package = pkgs.niri-unstable; # package from overlay above
  };

  services.dbus.packages = [ pkgs.nautilus ];

  environment.variables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    libsecret
    cage
    gamescope
    xwayland-satellite-unstable
  ];
}
