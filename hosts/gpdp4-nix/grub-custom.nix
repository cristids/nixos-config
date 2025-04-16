{ config, pkgs, lib, ... }:

pkgs.grub2.overrideAttrs (old: {
  pname = "grub2-fbrot";
  version = old.version + "-fbrot";

  patches = (old.patches or []) ++ [
    ./fb_rot.patch
  ];
})
