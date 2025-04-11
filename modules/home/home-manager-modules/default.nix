{ config, pkgs, ... }:
{
  imports = [
    ./autorotate.nix
    ./packages.nix
    ./packages-unstable.nix
#    ./bash.nix
#    ./bashrc-personal.nix
    ./bat.nix
    ./fastfetch
    ./gh.nix
    ./git.nix
    ./gtk.nix
#    ./nvf.nix
#    ./stylix.nix
    ./zsh
  ];
}
