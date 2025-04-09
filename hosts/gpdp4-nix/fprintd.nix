{
  services.udev.extraRules = ''
    # GPD Pocket 4 - FocalTech Fingerprint Reader (2808:0752)
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2808", ATTRS{idProduct}=="0752", MODE="0660", GROUP="plugdev", TAG+="uaccess"
  '';
}