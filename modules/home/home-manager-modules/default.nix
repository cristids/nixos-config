{ config, pkgs, ... }:
{
  imports = [
    ./azuredatastudio.nix
#    ./bash.nix
#    ./bashrc-personal.nix
    ./bat.nix
    ./fastfetch
    ./gh.nix
    ./git.nix
    ./gtk.nix
#    ./nvf.nix
#    ./stylix.nix
    ./vscode.nix
    ./zsh
  ];
}
