# {
#   description = "config flake";

#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
#   };

#   outputs = { self, nixpkgs, home-manager, ... }: {

#     nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
#       # NOTE: Change this to aarch64-linux if you are on ARM
#       system = "x86_64-linux";
#       hostname = "nixos";
#       modules = [
#         ./dell/drivers/hardware.nix
#         ./dell/drivers/video.nix
#         ./generic/configuration.nix

#         # # make home-manager as a module of nixos
#         # # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
#         # home-manager.nixosModules.home-manager
#         # {
#         #   home-manager.useGlobalPkgs = true;
#         #   home-manager.useUserPackages = true;
#         #   home-manager.backupFileExtension = "hm-bkp";

#         #   # TODO replace ryan with your own username
#         #   home-manager.users.cristian = import ./generic/home.nix;

#         #   # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
#         # }
#       ];
#     };

#   };
# }


{
  description = "Multi-host NixOS config";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";

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
        home-manager.users.cristian = import ./home/home.nix;
        # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix        
      }];
    };
  in {
    nixosConfigurations = {
      dell-nix = mkHost "dell-nix" [ ./hosts/dell-nix];
      gpdp4-nix = mkHost "gpdp4-nix" [ ./hosts/gpdp4-nix];
    };
  };
}
