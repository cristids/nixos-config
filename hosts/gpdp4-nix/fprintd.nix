{ config, pkgs, lib, stablePkgs, ... }:


let
  # Inline the custom package
  libfprint-focaltech = stablePkgs.callPackage ../../pkgs/libfprint-tod/package.nix {};
in 
{

  # Enable fprintd 
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd.override {
      libfprint = libfprint-focaltech;
    };
  };
}
