{ pkgs, config, ... }:
{
  boot = {

      kernelParams = ["quiet" "splash" "fbcon=rotate:1" "fbcon=rotate_all:1" "video=eDP-1:panel_orientation=right_side_up" "video=efifb:rotate=1" "video=efifb:panel_orientation=right_side_up"];

      loader = {
        systemd-boot.enable = false;
        grub.enable = true;
        grub.device = "nodev";
        grub.useOSProber = true;
        grub.efiSupport = true;
        grub.gfxmodeEfi = "1600x2560@32";
        grub.gfxpayloadEfi = "keep";
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
      };
  }
}