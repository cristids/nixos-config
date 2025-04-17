{ config, pkgs, lib, vars, ... }:
{
  imports = [
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
    # ./zsh
  ]
  ++ lib.optional (vars.hostName == "gpdp4-nix") ./autorotate.nix;
}
