{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.sway.enable = true;
  programs.uwsm.enable = false;
  #programs.uwsm.waylandCompositors.sway = {
  #  prettyName = "Sway";
  #  comment = "Sway compositor managed by UWSM";
  #  binPath = "/run/current-system/sw/bin/sway";
  #};

}
