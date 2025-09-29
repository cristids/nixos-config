{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Enable SDDM
  services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
     theme = "breeze";
  };

  #services.displayManager.cosmic-greeter.enable = true;
  #security.pam.services.cosmic-greeter.kwallet.enable = true;
  #security.pam.services.greetd.kwallet.enable = true;
  #security.pam.services.greetd.kwallet.package = pkgs.kdePackages.kwallet-pam;
}
