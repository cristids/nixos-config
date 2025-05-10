{
  config,
  pkgs,
  unstable,
  ...
}: let
  customAzureDataStudio = unstable.callPackage ../../../pkgs/azuredatastudio/package.nix {};
in {
  home.packages = with unstable; [
    _1password-gui
    affine
    #azuredatastudio
    customAzureDataStudio
    #vscode
    wl-clipboard
    amfora
    eog
  ];
}
