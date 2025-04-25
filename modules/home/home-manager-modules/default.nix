{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  imports =
    [
      ./packages.nix
      ./packages-unstable.nix
      #    ./bash.nix
      #    ./bashrc-personal.nix
      ./bat.nix
      ./fastfetch
      ./gh.nix
      ./git.nix
      ./gtk.nix
      # ./nixcats-nvim.nix
      # ./nixvim.nix
      # ./nvchad.nix
      # ./neovim.nix
      ./nvf.nix
      #  ./stylix.nix
      ./ohmyposh.nix
      # ./vscode.nix
      ./zsh
    ]
    ++ lib.optional (vars.hostName == "gpdp4-nix") ./autorotate.nix;
}
