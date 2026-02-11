{
  pkgs,
  inputs,
  #caelestia,
  ...
}:
{
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
  services.blueman-applet.enable = true;
  programs.rclone.enable = true;

  #imports = [ quickshell ];

  home.packages = with pkgs; [
    nextcloud-client
    dbeaver-bin

    #quickshell
    #quickshell.packages.${pkgs.system}.default
    #caelestia.packages.${pkgs.system}.default
    fish
    jq
    fd
    #(pkgs.python3.withPackages (
    #  python-pkgs: with python-pkgs; [
    #    aubio
    #    pyaudio
    #    numpy
    #  ]
    #))
    #cava
    #bluez
    #ddcutil
    brightnessctl
    curl
    material-symbols
  ];
}
