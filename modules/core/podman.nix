{ pkgs, ... }:
{
  # Enable common container config files in /etc/containers
  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      autoPrune.enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;

    };

    containers.storage.settings = {
      storage = {
        driver = "btrfs";
        runroot = "/run/containers/storage";
        graphroot = "/var/lib/containers/storage";
        options.overlay.mountopt = "nodev,metacopy=on";
      }; # storage
    };
  };

  # Enable user namespaces for rootless containers
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;

  # Configure user namespace mappings for your user
  # users.users.cristian = {
  #   subUidRanges = [
  #     { startUid = 100000; count = 65536; }
  #   ];
  #   subGidRanges = [
  #     { startGid = 100000; count = 65536; }
  #   ];
  # };

  users.users.cristian = {
      # required for auto start before user login
      linger = true;
      # required for rootless container with multiple users
      autoSubUidGidRange = true;
  };


  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    #docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
    podman-desktop
  ];
}
