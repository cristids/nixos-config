{
  pkgs,
  config,
  ...
}: {
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };

  # security.pam.services = { 
  #   sddm.kwallet = {
  #     enable = true;
  #     # enableKwallet = true;
  #     # package = pkgs.kdePackages.kwallet-pam; 
  #   };
  #   login.kwallet = { 
  #     enable = true; 
  #     # package = pkgs.kdePackages.kwallet-pam; 
  #   }; 
  #   kde = { 
  #     # allowNullPassword = true; 
  #     kwallet = { 
  #       enable = true; 
  #       # package = pkgs.kdePackages.kwallet-pam; 
  #     }; 
  #   }; 
  # };
  # security.pam.services.login.enableKwallet = true;

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
    kdePackages.gwenview
    kdePackages.kimageformats
    kdePackages.qtimageformats
    kdePackages.plasma-workspace

    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.kio
    kdePackages.kdf
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kio-admin
    kdePackages.qtwayland
    kdePackages.plasma-integration
    kdePackages.kdegraphics-thumbnailers
    kdePackages.breeze-icons
    kdePackages.qtsvg #https://www.reddit.com/r/hyprland/comments/18ecoo3/dolphin_doesnt_work_properly_in_nixos_hyprland/
    kdePackages.kservice
    kdePackages.kwallet # provides helper service
    kdePackages.kwallet-pam # provides helper service
    kdePackages.kwalletmanager # provides KCMs and stuff
    kdePackages.kalk
    kdePackages.kompare
    kdePackages.kglobalaccel
    kdePackages.kio

    krusader
    kdiff3
    # krename

    shared-mime-info
    
    maliit-keyboard

    # Application integration
    kdePackages.libplasma # provides Kirigami platform theme
    kdePackages.plasma-integration # provides Qt platform theme
    kdePackages.kde-gtk-config # syncs KDE settings to GTK

    # Artwork + themes
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.breeze-gtk
    kdePackages.ocean-sound-theme
    kdePackages.plasma-workspace-wallpapers
    hicolor-icon-theme # fallback icons
    kdePackages.qqc2-breeze-style
    kdePackages.qqc2-desktop-style

    # misc Plasma extras
    kdePackages.kdeplasma-addons
    xdg-user-dirs

    qt5.qttools
   
  ];
}

