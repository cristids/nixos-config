{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # nixpkgs.overlays = [
  #   (import ./grub-overlay.nix)
  # ];

  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./fprintd.nix
    ../../modules/drivers/amd.nix
    ./hhd.nix
  ];

  # This indicates the version of the system at the time of the first install.
  # Do not change this value when you upgrade your system.
  system.stateVersion = "24.11";
}

