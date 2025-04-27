{pkgs, ...}: {
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
  services.blueman-applet.enable = true;
}

