{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelParams = ["quiet" "splash"];

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      grub.enable = false;
      grub.device = "nodev";
      grub.useOSProber = true;
      grub.efiSupport = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
  };
}
