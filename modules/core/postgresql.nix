{ config, lib, pkgs, ... }:

{
  config.services.postgresql = {
    enable = true;
    ensureDatabases = [ "hra" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
