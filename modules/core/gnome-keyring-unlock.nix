{
  pkgs,
  config,
  ...
}: {
  # Enable gnome-keyring
  services.gnome.gnome-keyring.enable = true;

  # PAM: enable gnome-keyring for cosmic-greeter (auto-unlock on password login)
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

  # Disable fingerprint on greetd (first login after reboot) so password is required,
  # which allows gnome-keyring to auto-unlock.
  # cosmic-greeter (lock screen) keeps fingerprint enabled.
  security.pam.services.greetd.fprintAuth = false;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
