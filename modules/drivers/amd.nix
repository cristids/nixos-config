#amd.nix
{ config, lib, pkgs, ... }:
{
    # Enable OpenGL
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    services.xserver.videoDrivers = ["amdgpu"];
}
