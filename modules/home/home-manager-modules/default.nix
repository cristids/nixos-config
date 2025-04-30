{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  imports = [
    ./packages.nix
    ./packages-unstable.nix
    ./amfora.nix
    #    ./bash.nix
    #    ./bashrc-personal.nix
    ./bat.nix
    ./btop.nix
    ./emoji.nix
    ./gh.nix
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./hyprland
    ./kitty.nix
    # ./nixcats-nvim.nix
    # ./nixvim.nix
    # ./nvchad.nix
    # ./neovim.nix
    ./nh.nix
    ./nvf.nix
    ./services.nix
    ./stylix.nix
    ./ohmyposh.nix
    # ./vscode.nix
    ./wezterm.nix
    ./xdg.nix
    ./zoxide.nix
    ./zsh
    ./iiorient.nix
    ./iior.nix
  ];
  #    ++ lib.optional (vars.hostName == "gpdp4-nix") ./autorotate.nix;
}
