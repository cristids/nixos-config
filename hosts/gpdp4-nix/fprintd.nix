{
  services.udev.extraRules = ''
    # FocalTech fingerprint sensor
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2808", ATTRS{idProduct}=="*", ATTRS{dev}=="*", \
      TEST=="power/control", ATTR{power/control}="auto", MODE="0660", GROUP="plugdev"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2808", ATTRS{idProduct}=="*", \
      ENV{LIBFPRINT_DRIVER}="FocalTech Systems Co., Ltd Fingerprint"
  '';
}