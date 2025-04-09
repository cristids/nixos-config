{ config, pkgs, unstable, ... }:

{
  home.packages = [
    unstable.vscode
  ];
}