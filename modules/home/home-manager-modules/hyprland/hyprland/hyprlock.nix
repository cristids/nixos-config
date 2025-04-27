{...}: let
  username = "cristian";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
        ignore_empty_input = true;
      };
      auth = {
        "fingerprint:enabled" = true;
        "pam:enabled" = true;
        "fingerprint:ready_message" = "(Scan fingerprint to unlock)";
        "fingerprint:present_message" = "Scanning fingerprint";
        "fingerprint:retry_delay" = 250;
      };
      background = [
        {
          path = "/home/${username}/Pictures/Wallpapers/beautifulmountainscape.jpg";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      image = [
        {
          path = "/home/${username}/.config/face.jpg";
          size = 150;
          border_size = 4;
          border_color = "rgb(0C96F9)";
          rounding = -1; # Negative means circle
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(CFE6F4)";
          inner_color = "rgb(657DC2)";
          outer_color = "rgb(0D0E15)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
      label = [
        {
          monitor = "";
          text = "Scan your finger instead of typing password";
          font_color = "rgb(CFE6F4)";
          font_size = 16;
          position = "0, 40"; # This places the label nicely below
          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
