{
  config,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      grub2 = prev.grub2.overrideAttrs (old: {
        patches = (old.patches or []) ++ [
          ./grub-rotation-patches/0001.patch
          ./grub-rotation-patches/0002.patch
          ./grub-rotation-patches/0003.patch
          ./grub-rotation-patches/0004.patch
        ];
        postPatch = (old.postPatch or "") + ''
          sed -i 's/const char \*rot_env;/const char *rot_env __attribute__((unused));/' grub-core/video/fb/video_fb.c
        '';
      });
    })
  ];
  services.udev.enable = true;

  environment.etc."udev/hwdb.d/61-sensor-local.hwdb".text = ''
    sensor:modalias:acpi:MXC*
     ACCEL_MOUNT_MATRIX=-1,0,0;0,1,0;0,0,1

     ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{name}=="MXC6655", ENV{LIBINPUT_CALIBRATION_MATRIX}="0 1 0 -1 0 1"
  '';

  boot = {
    kernelParams = ["quiet" "splash" "fbcon=rotate:1" "fbcon=rotate_all:1" "video=eDP-1:panel_orientation=right_side_up" "video=efifb:rotate=1" "video=efifb:panel_orientation=right_side_up"];

    loader = {
      systemd-boot.enable = false;
      grub.enable = true;
      grub.device = "nodev";
      grub.useOSProber = true;
      grub.efiSupport = true;
      grub.gfxmodeEfi = "1600x2560x32-270";
      grub.gfxpayloadEfi = "keep";
      grub.splashImage = ../../modules/home/wallpapers/Tree_dark.png;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      grub.extraConfig = ''
        set rotation=270
      '';

      limine = {
        enable = false;
        enableEditor = true;
        style = {
          wallpapers = [ ../../modules/home/wallpapers/Tree_dark.png];
        };
      };
    };
  };

  # Chassis type override — GPD Pocket 4 is a convertible but DMI reports "Notebook"
  environment.etc."machine-info".text = ''
    CHASSIS="convertible"
  '';
}
