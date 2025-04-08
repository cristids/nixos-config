{
  imports = [ 
      ./hardware-configuration.nix 
      ../../modules/drivers/amd.nix
  ];

  # This indicates the version of the system at the time of the first install.
  # Do not change this value when you upgrade your system.
  system.stateVersion = "24.11";
}