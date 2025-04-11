{ config, pkgs, unstable, ... }:

{
  home.packages.unstable = [
    _1password-gui
    affine
    azuredatastudio
    vscode
  ];
}