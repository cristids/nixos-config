{...}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      #      {
      #        output = {
      #          criteria = "HSX YHB03P24 0x00888888";
      #          mode = "1600x2560@60";
      #          scale = 1.6;
      #          status = "enable";
      #          position = "0x0";
      #          transform = "270";
      #        };
      #      }

      {
        profile = {
          name = "undocked";
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
          name = "work";
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
              transform = "270";
              mode = "1600x2560@144";
              scale = 1.0;
            }
          ];
        };
      }
    ];
  };
}
