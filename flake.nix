{
  description = "Multi-host NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    nvf = {
     url = "github:notashelf/nvf";
     # url = "github:howird/nvf";
     # You can override the input nixpkgs to follow your system's
     # instance of nixpkgs. This is safe to do as nvf does not depend
     # on a binary cache.
     inputs.nixpkgs.follows = "nixpkgs";
     # Optionally, you can also override individual plugins
     # for example:
     # inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
    };

    # nvchad4nix = {
    #   url = "github:nix-community/nix4nvchad";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    #   # url = "github:nix-community/nixvim/nixos-24.11";

    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixCats = {
    #   url = "github:BirdeeHub/nixCats-nvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    unstablePkgs = import inputs.unstable {
      inherit system;
      config.allowUnfree = true;
    };

    stablePkgs = import inputs.stable {
      inherit system;
      config.allowUnfree = true;
    };

    sharedModules = [
      ./modules/core/configuration.nix
      home-manager.nixosModules.home-manager
    ];

    mkHost = name: hostModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs unstablePkgs stablePkgs;
        };
        modules =
          sharedModules
          ++ hostModules
          ++ [
            {
              networking.hostName = name;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bkp";
              home-manager.users.cristian = import ./modules/home/home.nix;
              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                unstable = unstablePkgs;
                vars.hostName = name;
                # nvchadModule = inputs.nvchad4nix.homeManagerModule;
                nvfModule = inputs.nvf;
                # nixvim = inputs.nixvim;
                # nixCats = inputs.nixCats;
              };
            }
          ];
      };
  in {
    nixosConfigurations = {
      dell-nix = mkHost "dell-nix" [./hosts/dell-nix];
      gpdp4-nix = mkHost "gpdp4-nix" [./hosts/gpdp4-nix];
    };
  };
}
