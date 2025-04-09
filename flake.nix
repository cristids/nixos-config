{
  description = "Multi-host NixOS config";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    system = "x86_64-linux";

    unstablePkgs = import inputs.unstable {
      inherit system;
      config.allowUnfree = true;
    };


    sharedModules = [
      ./modules/core/configuration.nix
       home-manager.nixosModules.home-manager
    ];

    # overlays = [
    #   (import ./overlays/custom.nix)
    # ];

    mkHost = name: hostModules: nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = sharedModules ++ hostModules ++ [{
        networking.hostName = name;
        # nixpkgs.overlays = overlays;

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bkp";
        home-manager.users.cristian = import ./modules/home/home.nix;
        # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix 
        home-manager.extraSpecialArgs = { 
          unstable = unstablePkgs;
        };       
      }];
    };
  in {
    nixosConfigurations = {
      dell-nix = mkHost "dell-nix" [ ./hosts/dell-nix];
      gpdp4-nix = mkHost "gpdp4-nix" [ ./hosts/gpdp4-nix];
    };
  };
}
