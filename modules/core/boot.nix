{ pkgs, config, ... }:

{
  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = { "vm.max_map_count" = 2147483642; };
    #kernelParams = ["video=1600x2560" "rotate=270" "fbcon=rotate:1" "fbcon=rotate_all:1" "video=efifb" ];
#"video=efifb:panel_orientation=right_side_up" "video=eDP-1:panel_orientation=right_side_up"
    kernelParams = ["quiet" "splash" "fbcon=rotate:1" "fbcon=rotate_all:1" "video=eDP-1:panel_orientation=right_side_up" "video=efifb:rotate=1" "video=efifb:panel_orientation=right_side_up"];
    loader = {
      systemd-boot.enable = false;
      grub.enable = true;
      grub.device = "nodev";
      grub.useOSProber = true;
      grub.efiSupport = true;
      grub.gfxmodeEfi = "1600x2560@32";
      grub.gfxpayloadEfi = "keep";
#       grub.extraConfig = "GRUB_FB_ROTATION='inverted'";
#      grub.extraConfig = ''
#GRUB_CMDLINE_LINUX="video=1600x2560,rotate=270,video=efifb:panel_orientation=right_side_up #video=eDP-1:panel_orientation=right_side_up fbcon=rotate:1 fbcon=rotate_all:1"
##GRUB_GFXMODE=1600x2560
#GRUB_GFXMODE=2560x1600
#GRUB_FB_ROTATION='inverted'
#GRUB_GFXPAYLOAD_LINUX='keep'
#        '';
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };

    # Bootloader
#     loader.systemd-boot.enable = true;
#     loader.efi.canTouchEfiVariables = true;

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };
}
