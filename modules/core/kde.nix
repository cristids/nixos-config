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



    shared-mime-info
    
    maliit-keyboard

    
  ];
}

