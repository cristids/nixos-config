{ config, pkgs, ... }:
{
  imports = [
#    ./bash.nix
#    ./bashrc-personal.nix
    ./bat.nix
    ./gh.nix
    ./git.nix
    ./gtk.nix
#    ./nvf.nix
#    ./stylix.nix

    ./fastfetch
    ./zsh
  ];
}
