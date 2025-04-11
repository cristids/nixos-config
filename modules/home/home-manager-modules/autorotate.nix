{ config, pkgs, ... }:

let
  autorotateScript = pkgs.writeShellScriptBin "autorotate" (builtins.readFile ./autorotate.sh);
in {
  home.packages = [ autorotateScript ];

  systemd.user.services.autorotate = {
    Unit = {
      Description = "Auto screen rotation using monitor-sensor";
      After = [ "graphical-session.target" ];
    };

     Service = {
      ExecStart = "${autorotateScript}/bin/autorotate";
      Restart = "on-failure";
      # Environment = [
      #   "DISPLAY=:0"
      #   # "XDG_RUNTIME_DIR=/run/user/${toString config.home.user.uid}"
      #   "WAYLAND_DISPLAY=wayland-0"
      # ];
    };
    
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
