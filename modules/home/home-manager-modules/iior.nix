{...}: {
  services.iiorient = {
    enable = true;
    handler = "hyprctl"; # Only "hyprctl" is supported for now
    #devices = [ "your-touchscreen-device" ];
    #monitors = [ "your-monitor-name" ];
  };
}
