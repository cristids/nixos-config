{ config, lib, pkgs, inputs,quadletModule, ... }:

{
  imports = [ quadletModule ];

  # This is crucial to ensure the systemd services are (re)started on config change
  systemd.user.startServices = "sd-switch";
  virtualisation.quadlet.containers = {
      python-server = {
        autoStart = true;
        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
        containerConfig = {
          image = "docker.io/python:3.12-slim";
          publishPorts = [ "127.0.0.1:8080:8080" ];
          userns = "keep-id";
          exec = [ "python3 -m http.server 8080" ];
          workdir = "/srv";
          volumes = [
            "/home/cristian/www:/srv:Z"
          ];
      };
    };
  };
}
