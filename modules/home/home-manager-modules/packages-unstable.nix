{
  config,
  pkgs,
  unstable,
  ...
}: let
  # vscode-generic = import (unstable.path + "/pkgs/applications/editors/vscode/generic.nix") {
  #   inherit (unstable) lib stdenv buildFHSEnv
  #      buildPackages systemd fontconfig
  #     xorg nss bash src  makeDesktopItem sourceRoot openssl
  #     wayland alsa-lib shortName unzip updateScript autoPatchelfHook
  #     glib ripgrep asar libdbusmenu libglvnd libsecret nspr tests libkrb5
  #     copyDesktopItems at-spi2-atk libgbm libXScrnSaver libxshmfence commandLineArgs
  #     executableName longName;
  #   meta = {};
  #   version = {};
  #   pname = {};
  # };
  vscode-generic =  unstable.callPackage ../../../pkgs/vscode/generic.nix;
  customAzureDataStudio = unstable.callPackage ../../../pkgs/azuredatastudio/package.nix {};
  customCursor = unstable.callPackage ../../../pkgs/code-cursor/package.nix {
    inherit vscode-generic;
  };

in {
  home.packages = with unstable; [
    _1password-gui
    affine
    #azuredatastudio
    customCursor
    customAzureDataStudio
    #vscode
    wl-clipboard
    amfora
    eog
  ];
}
