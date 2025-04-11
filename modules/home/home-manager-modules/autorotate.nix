{ config, pkgs, ... }:

let
  autorotateScript = pkgs.writeShellScript "autorotate" (builtins.readFile ./autorotate.sh);
in {
  home.packages = [ autorotateScript ];

  systemd.user.services.autorotate = {
    Unit = {
      Description = "Auto screen rotation using monitor-sensor";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${autorotateScript}";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
