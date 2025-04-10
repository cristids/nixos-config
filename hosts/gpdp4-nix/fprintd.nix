# { pkgs, config, lib,  ... }:
# # let
# #   focaltechDriver = pkgs.runCommand "focaltech-tod" { } ''
# #     mkdir -p $out/lib/libfprint-2/tod-1
# #     cp /home/cristian/focaltech-driver/libfprint-2.so.2.0.0 $out/lib/libfprint-2/tod-1/libfprint-focaltech.so
# #   '';
# # in {
# let
#   libfprintTod = pkgs.callPackage ../../pkgs/libfprint-tod/package.nix {};
# in {
#   nixpkgs.config.allowUnfree = true;

#   environment.systemPackages = with pkgs; [
#     libfprintTod
#   ];

#   # services.udev.extraRules = ''
#   #   # GPD Pocket 4 - FocalTech Fingerprint Reader (2808:0752)
#   #   # SUBSYSTEM=="usb", ATTRS{idVendor}=="2808", ATTRS{idProduct}=="0752", MODE="0660", GROUP="plugdev", TAG+="uaccess"
    
#   #   # FocalTech Systems Co., Ltd Fingerprint
#   #   SUBSYSTEM=="usb", ATTRS{idVendor}=="2808", ATTRS{idProduct}=="*", ATTRS{dev}=="*", TEST=="power/control", ATTR{power/control}="auto", MODE="0660", GROUP="plugdev"
#   #   SUBSYSTEM=="usb", ATTRS{idVendor}=="2808", ATTRS{idProduct}=="*", ENV{LIBFPRINT_DRIVER}="FocalTech Systems Co., Ltd Fingerprint"
#   # '';

#   # environment.systemPackages = with pkgs; [
#   #   # fprintd
#   #   fprintd
#   #   libfprint-focaltech-2808-a658
#   # ];
#   # # fprintd configuration


#   services.fprintd.tod.enable = true;
#   services.fprintd.tod.driver = pkgs.libfprintTod;
#   # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
#   # services.fprintd.tod.driver = pkgs.libfprint-focaltech-2808-a658;
#   # services.fprintd = {
#   #   enable = true;
#   #   tod.enable = true;
#   #   tod.driver = "${focaltechDriver}/lib/libfprint-2/tod-1/libfprint-focaltech.so";
#   # };
  
#   # environment.systemPackages = with pkgs; [
#   #   fprintd
#   #   libfprint-focaltech-2808-a658
#   # ];

# }

{ config, pkgs, lib, ... }:

let
  # Inline the custom package
  libfprintTod = pkgs.callPackage ../../pkgs/libfprint-tod/package.nix {};
in {
  # Enable fprintd with tod driver
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = libfprintTod;

  # Include the package in systemPackages for CLI access if needed
  environment.systemPackages = [ libfprintTod ];

  # Ensure udev rules are active
  services.udev.packages = [ libfprintTod ];

  # Optional: Allow unfree for this host if you haven't globally
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "libfprint-2-2-tod"
  ];
}
