{ pkgs, config, lib, unstablePkgs, ... }:
let
  inherit (unstablePkgs) kdePackages maliit-keyboard;

  myKdePkgs = with kdePackages; [
    # kate
    sddm-kcm
    kcmutils
    plymouth-kcm
    kdeplasma-addons

    qtwayland # Hack? To make everything run on Wayland
          qtsvg # Needed to render SVG icons

          # Frameworks with globally loadable bits
          frameworkintegration # provides Qt plugin
          kauth # provides helper service
          kcoreaddons # provides extra mime type info
          kded # provides helper service
          kfilemetadata # provides Qt plugins
          kguiaddons # provides geo URL handlers
          kiconthemes # provides Qt plugins
          kimageformats # provides Qt plugins
          qtimageformats # provides optional image formats such as .webp and .avif
          kio # provides helper service + a bunch of other stuff
          kio-admin # managing files as admin
          kio-extras # stuff for MTP, AFC, etc
          kio-fuse # fuse interface for KIO
          kpackage # provides kpackagetool tool
          kservice # provides kbuildsycoca6 tool
          kunifiedpush # provides a background service and a KCM
          kwallet # provides helper service
          kwallet-pam # provides helper service
          kwalletmanager # provides KCMs and stuff
          plasma-activities # provides plasma-activities-cli tool
          solid # provides solid-hardware6 tool
          phonon-vlc # provides Phonon plugin

          # Core Plasma parts
          kwin
          kscreen
          libkscreen
          kscreenlocker
          kactivitymanagerd
          kde-cli-tools
          kglobalacceld # keyboard shortcut daemon
          kwrited # wall message proxy, not to be confused with kwrite
          baloo # system indexer
          milou # search engine atop baloo
          kdegraphics-thumbnailers # pdf etc thumbnailer
          polkit-kde-agent-1 # polkit auth ui
          plasma-desktop
          plasma-workspace
          drkonqi # crash handler
          kde-inotify-survey # warns the user on low inotifywatch limits

          # Application integration
          libplasma # provides Kirigami platform theme
          plasma-integration # provides Qt platform theme
          kde-gtk-config # syncs KDE settings to GTK

          # Artwork + themes
          breeze
          breeze-icons
          breeze-gtk
          ocean-sound-theme
          plasma-workspace-wallpapers
          pkgs.hicolor-icon-theme # fallback icons
          qqc2-breeze-style
          qqc2-desktop-style

          # misc Plasma extras
          kdeplasma-addons
          pkgs.xdg-user-dirs # recommended upstream

          # Plasma utilities
          kmenuedit
          kinfocenter
          plasma-systemmonitor
          ksystemstats
          libksysguard
          systemsettings
          kcmutils

          #Optional
          plasma-browser-integration
            konsole
            (lib.getBin qttools) # Expose qdbus in PATH
            ark
            elisa
            gwenview
            okular
            kate
            khelpcenter
            dolphin
            baloo-widgets # baloo information in Dolphin
            dolphin-plugins
            spectacle
            ffmpegthumbs
            krdp
            xwaylandvideobridge # exposes Wayland windows to X11 screen capture

  ];
in {
  disabledModules = [ 
    "services/desktop-managers/plasma6.nix"
    "services/display-managers/sddm.nix" 
    "config/pulseaudio.nix"
  ];
  imports =
  [ # Use postgresql service from nixos-unstable channel.
    # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
    <nixos-unstable/nixos/modules/services/desktop-managers/plasma6.nix>
    <nixos-unstable/nixos/modules/services/display-managers/sddm.nix>
    <nixos-unstable/nixos/modules/services/audio/pulseaudio.nix>
  ];



  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
      enable = true;
  };
  services.desktopManager.plasma6 = {
      enable = true;
  };

  services.pulseaudio.enable = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = myKdePkgs ++ [
    maliit-keyboard
  ];
}