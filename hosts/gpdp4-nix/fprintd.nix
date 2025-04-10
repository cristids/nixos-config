{ config, pkgs, lib, ... }:

let
  # Inline the custom package
  libfprint-focaltech = pkgs.callPackage ../../pkgs/libfprint-tod/package.nix {};
in {

  # Enable fprintd 
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd.override {
      libfprint = focaltech;
    };
  };
}
