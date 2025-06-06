{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    firefox.enable = true; # Firefox is not installed by default
    dconf.enable = true;
    mtr.enable = true;
    adb.enable = true;

    steam = {
      enable = true;
      #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      #localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    zsh.enable = true;

    #         git = {
    #             enable = true;
    #             package = pkgs.gitFull;
    #             config.credential.helper = "libsecret";
    #         };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    appimage-run # Needed For AppImage Support
    brave # Brave Browser
    duf # Utility For Viewing Disk Usage In Terminal
    eza # Beautiful ls Replacement
    ffmpeg # Terminal Video / Audio Editing
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    nixfmt-rfc-style # Nix Formatter
    pciutils # Collection Of Tools For Inspecting PCI Devices
    rhythmbox
    ripgrep # Improved Grep
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    v4l-utils # Used For Things Like OBS Virtual Camera
    wget # Tool For Fetching Files With Links
    yazi # TUI File Manager
    zip # Tool For Handling .zip Files
    lha # Tool For Handling .lha Files
    jq # jq is a lightweight and flexible command-line JSON processor
    lsof # lsof is a command that lists open files and the processes that opened them
    doublecmd # Double Commander is a cross platform open source file manager with two panels side by side

    
    wget
    # vscode
    # azuredatastudio
    mc
    rambox
    gcc
    gnumake
    ripgrep
    # nodejs_23
    # python3
    transmission_4-qt

    obs-studio
    onlyoffice-desktopeditors
    #libreoffice-qt-fresh
    zoom-us
    tlrc
    hplip
    hplipWithPlugin
  ];
}
