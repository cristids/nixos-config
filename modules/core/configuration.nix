# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./services.nix
    ./packages.nix
    ./emacs.nix
    ./zsh.nix
    #./kde.nix
    ./fonts.nix
    ./wayland
    #./kde-unstable.nix
    #./hyprland.nix
    #./cosmic.nix
  ];

  nix.settings.download-buffer-size = 536870912; # 512 MiB;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #automatically remove generations older than 14d
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 14d";

  #   nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  #This allows X applications like chromium and electron to run without Xwayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.FLAKE = "/home/cristian/cristids/nixos-config";

  # Enable sound with pipewire.

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  hardware.sensor.iio.enable = true;

  #security.rtkit.enable = true;

  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
      #extraConfig = ''
      #    polkit.addRule(function(action, subject) {
      #    if ( subject.isInGroup("users") && (
      #     action.id == "org.freedesktop.login1.reboot" ||
      #     action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
      #     action.id == "org.freedesktop.login1.power-off" ||
      #     action.id == "org.freedesktop.login1.power-off-multiple-sessions"
      #    ))
      #    { return polkit.Result.YES; }
      #  })
      #'';
    };
    pam.services.swaylock = {
      text = ''auth include login '';
    };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cristian = {
    isNormalUser = true;
    description = "Cristian Stamateanu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "plugdev"
      "pipewire"
      "bluetooth"
      "audio"
      "video"
      "tablet"
      "input"
      "adbusers"
      "dialout"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #  thunderbird
    ];
  };
}
