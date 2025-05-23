{...}: {
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session    # lock before suspend.";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          ignore_systemd_inhibit = false;
          inhibit_sleep = 2;
          lock_cmd = "pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.";
        };
        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.";
            on-resume = "brightnessctl -r                 # monitor backlight restore.";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.";
            on-resume = "brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.";
          }

          {
            timeout = 300;
            on-timeout = "loginctl lock-session            # lock screen when timeout has passed";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off # screen off when timeout has passed";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r          # screen on when activity is detected after timeout has fired.";
          }
          {
            timeout = 1800; # 30min
            on-timeout = "systemctl suspend                # suspend pc";
          }
        ];
      };
    };
  };
}
