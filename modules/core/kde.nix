{ pkgs, config,  ... }:
{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
      enable = true;
  };
  services.desktopManager.plasma6 = {
      enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.sddm-kcm
    kdePackages.kcmutils
    kdePackages.plymouth-kcm
    kdePackages.kdeplasma-addons
    maliit-keyboard
  ];
}