{ pkgs, config, ... }:
{
  boot = {

      kernelParams = ["quiet" "splash" ];

      loader = {
        systemd-boot.enable = false;
        grub.enable = true;
        grub.device = "nodev";
        grub.useOSProber = true;
        grub.efiSupport = true;
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
      };
  };
}