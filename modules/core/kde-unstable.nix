{ pkgs, config, unstablePkgs, ... }:
{
  disabledModules = [ 
    "services/desktop-managers/plasma6.nix"
    "services/display-managers/sddm.nix" 
  ];
  imports =
  [ # Use postgresql service from nixos-unstable channel.
    # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
    <nixos-unstable/nixos/modules/services/desktop-managers/plasma6.nix>
    <nixos-unstable/nixos/modules/services/display-managers/sddm.nix>
  ];



  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
      enable = true;
  };
  services.desktopManager.plasma6 = {
      enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with unstablePkgs; [
    kdePackages.kate
    kdePackages.sddm-kcm
    kdePackages.kcmutils
    kdePackages.plymouth-kcm
    kdePackages.kdeplasma-addons
    maliit-keyboard
  ];
}