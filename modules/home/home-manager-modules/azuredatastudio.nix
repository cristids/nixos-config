{ config, pkgs, unstable, ... }:

{
  home.packages = [
    unstable.azuredatastudio
  ];
}