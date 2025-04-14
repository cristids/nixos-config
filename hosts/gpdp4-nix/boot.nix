{ pkgs, config, ... }:
{
  services.udev.enable = true;

#   services.udev.extraHwdb = ''
#   sensor:modalias:acpi:MXC6655*:dmi:*:svnGPD:pnG1621-02:*
#    ACCEL_MOUNT_MATRIX=-1,0,0;0,1,0;0,0,1
# '';

# services.udev.extraHwdb = ''
#   sensor:modalias:acpi:TESTMATCH*:*
#    ACCEL_MOUNT_MATRIX=9,9,9;9,9,9;9,9,9
# '';

# services.udev.extraHwdb = ''
# sensor:modalias:acpi:MXC6655:MXC6655::dmi:*svnGPD:pnG1628-04:*
#  ACCEL_MOUNT_MATRIX=-1,0,0;0,1,0;0,0,1
# '';
# services.udev.extraHwdb = ''
#   sensor:modalias:acpi:MXC6655:MXC6655::dmi:*
#    ACCEL_MOUNT_MATRIX=-1,0,0;0,1,0;0,0,1
# '';

# services.udev.extraRules = ''
#   ACTION=="add", SUBSYSTEM=="iio", ATTRS{name}=="MXC6655", ENV{ID_INPUT_TABLET_MODE}="1"
# '';

# services.udev.extraRules = ''
#   ACTION=="add", KERNEL=="iio:device0", ENV{ID_INPUT_TABLET_MODE}="1"
# '';

environment.etc."udev/hwdb.d/61-sensor-local.hwdb".text = ''
sensor:modalias:acpi:MXC*
 ACCEL_MOUNT_MATRIX=-1,0,0;0,1,0;0,0,1
'';

#THEN RUN
#sudo systemd-hwdb update
#sudo udevadm trigger -v -p DEVNAME=/dev/iio:device0
#sudo systemctl restart iio-sensor-proxy.service


# ACCEL_MOUNT_MATRIX=-1,0,0;0,1,0;0,0,1
# If needed, you can rotate the default matrix like this:
# Rotation	  Matrix
# Normal	    -1,0,0;0,1,0;0,0,1
# 90° CCW	    0,1,0;-1,0,0;0,0,1 ← probably what you want
# 180°	      1,0,0;0,-1,0;0,0,1
# 270° CCW	  0,-1,0;1,0,0;0,0,1


  boot = {

      kernelParams = ["quiet" "splash" "fbcon=rotate:1" "fbcon=rotate_all:1" "video=eDP-1:panel_orientation=right_side_up" "video=efifb:rotate=1" "video=efifb:panel_orientation=right_side_up"];

      loader = {
        # grub.package = import ./grub-custom.nix;
        systemd-boot.enable = false;
        grub.enable = true;
        grub.device = "nodev";
        grub.useOSProber = true;
        grub.efiSupport = true;
        grub.gfxmodeEfi = "1600x2560@32";
        grub.gfxpayloadEfi = "keep";
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
         # Inject memrw and patching code into all GRUB menu entries
grub.extraConfig = ''
insmod memrw
write_byte 0x78047116 0x1f 
#cat /sys/class/dmi/id/chassis_type    should return 31 meaning 0x1f
#write_byte 0x45da4116 0x1f
'';


        # grub.extraConfig = ''
#           insmod ($root)/grub/x86_64-efi/memrw.mod
#           write_byte 0x45da4116 0x1f
#         '';
# echo "insmod memrw"
# echo "write_byte 0x45da4116 0x1f"

        # grub.extraModules = [ "memrw" ];
      };  
  };
}