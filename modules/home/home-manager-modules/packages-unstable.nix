{ config, pkgs, unstable, ... }:

{
  home.packages = with unstable;[
    _1password-gui
    affine
    azuredatastudio
    vscode
 
  ];
}