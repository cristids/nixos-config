{ pkgs, inputs, ... }:
{
    programs = {
        firefox.enable = true; # Firefox is not installed by default
        dconf.enable = true;
        mtr.enable = true;

        steam = {
            enable = true;
            #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            #localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
            gamescopeSession.enable = true;
            extraCompatPackages = [pkgs.proton-ge-bin];
        };

        gamescope = {
            enable = true;
            capSysNice = true;
            args = [
                "--rt"
                "--expose-wayland"
            ];
        };

#         git = {
#             enable = true;
#             package = pkgs.gitFull;
#             config.credential.helper = "libsecret";
#         };

         zsh = {
            enable = true;
            ohMyZsh = {
                enable = true;
                theme = "agnoster";
                customPkgs = with pkgs; [
                    nix-zsh-completions
                    zsh-history
                    zsh-fzf-tab
                    zsh-completions
                ];
                plugins = [
                    "git"
                    "history"
    #                 "nix-zsh-completions"
                    "web-search"
    #                 "zsh-autosuggestions"
    #                 "zsh-syntax-highlighting"
    #                 "fast-syntax-highlighting"
                    "copyfile"
                    "copybuffer"
                    "dirhistory"
                ];
            };
         };

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
        yazi #TUI File Manager

        wget
        vscode
        azuredatastudio
        mc
        rambox
        _1password-gui
        unixODBCDrivers.msodbcsql18
        obs-studio
        onlyoffice-desktopeditors
        libreoffice-qt-fresh
        zoom-us
        tlrc
#        mplayer
#        vlc
#         xorg.xrandr
    ];
}
