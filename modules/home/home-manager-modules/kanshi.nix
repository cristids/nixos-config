{...}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile = {
          name = "undocked_gpd";
          outputs = [
            {
              criteria = "HSX YHB03P24 0x00888888";
              mode = "1600x2560@60";
              scale = 1.6;
              status = "enable";
              position = "0,0";
              transform = "270";
            }
          ];
        };
      }
      {
        profile = {
          name = "undocked_dell";
          outputs = [
            {
              criteria = "Samsung Display Corp. 0x414D Unknown";
              scale = 2.0;
              status = "enable";
            }
          ];
        };
      }

      {
        profile = {
          name = "work_gpd";
          outputs = [
            {
              criteria = "LG Electronics LG ULTRAWIDE 0x00022B4F";
              position = "0,0";
              mode = "3440x1440";
              scale = 1.0;
            }
            {
              criteria = "HSX YHB03P24 0x00888888";
              status = "disable";
            }
          ];
        };
      }

      {
        profile = {
          name = "work_dell";
          outputs = [
            {
              criteria = "LG Electronics LG ULTRAWIDE 0x00022B4F";
              position = "0,0";
              mode = "3440x1440";
              scale = 1.0;
            }
            {
              criteria = "Samsung Display Corp. 0x414D Unknown";
              status = "disable";
            }
          ];
        };
      }

      {
        profile = {
          name = "home";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-2";
              mode = "5120x2880";
              position = "0,0"; #= ((Odyssey h) - ((DP-2 h) /2))/2 = (2160 - (2880/2))/2 = 360
              scale = 2.0;
            }
            {
              criteria = "DP-3";
              status = "disable";
            }
            {
              criteria = "Samsung Electric Company Odyssey G8 HNBW900015";
              position = "2560,0";
              mode = "3840x2160";
              scale = 1.5;
            }
          ];
        };
      }

      {
        profile = {
          name = "home_ody";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "Samsung Electric Company Odyssey G8 HNBW900015";
              position = "0,0";
              mode = "3840x2160";
              scale = 1.5;
            }
          ];
        };
      }

      {
        profile = {
          name = "home_apple";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "DP-2";
              position = "0,0";
              mode = "5120x2880";
              scale = 2.0;
            }
            {
              criteria = "DP-3";
              status = "disable";
            }
          ];
        };
      }
    ];
  };
}
