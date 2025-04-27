{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    brightnessctl # For Screen Brightness Control
    cliphist # Clipboard manager using rofi menu
    hyprpicker # Color Picker
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    mpv # Incredible Video Player
    nwg-displays #configure monitor configs via GUI
    socat # Needed For Screenshots
    pavucontrol # For Editing Audio Levels & Devices
  ];
}
