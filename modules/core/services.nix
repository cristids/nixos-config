{
  pkgs,
  config,
  unstablePkgs,
  ...
}: {
  services = {
    acpid.enable = true;
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    openssh.enable = false; # Enable SSH
    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview

    btrfs.autoScrub = {
      enable = true;
      interval = "weekly"; # You can also use "monthly"
      fileSystems = ["/"]; # Add other Btrfs mount points if needed
    };

    smartd = {
      enable = true;
      autodetect = true;
      notifications = {
        mail.enable = false;
        wall.enable = true; # Shows alerts in the terminal
      };
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    #xserver.displayManager.gdm.enable = true;
    #xserver.desktopManager.gnome.enable = true;

    # gnome.gnome-keyring.enable = true;

    onedrive.enable = true;
    tailscale.enable = true;
    fprintd.enable = true;

    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    #         xserver.enable = true;

    # Configure keymap in X11
    # xserver.xkb = {
    #     layout = "us";
    #     variant = "";
    # };

    # Enable touchpad support (enabled default in most desktopManager).
    # xserver.libinput.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    #         udev.extraRules = ''
    #             # Rotate display
    #             ACTION=="add", KERNEL=="card0", SUBSYSTEM=="drm", ENV{ID_PATH}=="*platform-*", RUN+="xrandr --output eDP-1 --rotate right"
    #             '';
  };
}
