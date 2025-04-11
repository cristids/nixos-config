{ config, pkgs, ... }:

let
  autorotateScript = pkgs.writeShellScriptBin "autorotate" (builtins.readFile ./autorotate.sh);
in {
  home.packages = [ autorotateScript ];

  systemd.user.services.autorotate = {
    Unit = {
      Description = "Auto screen rotation using monitor-sensor";
      After = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
      ExecStart = "${autorotateScript}/bin/autorotate";
      Restart = "on-failure";

      # Optional: If DISPLAY/WAYLAND is still flaky, you can inject them manually
      # Environment = [
      #   "DISPLAY=:0"
      #   "WAYLAND_DISPLAY=wayland-0"
      #   "XDG_RUNTIME_DIR=/run/user/${toString config.home.user.uid}"
      # ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
