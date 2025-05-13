{
  description = "Multi-host NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    nvfpkgs = {
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

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
    #   # url = "github:nix-community/nixvim/nixos-24.11";

    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixCats = {
    #   #url = "github:BirdeeHub/nixCats-nvim";
    #   url = "github:BirdeeHub/nixCats-nvim?dir=templates/LazyVim";
    #   #inputs.nixpkgs.follows = "nixpkgs";
    # };

    stylix = {
      #url = "github:danth/stylix";
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix4vscode = {
    #   url = "github:nix-community/nix4vscode";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions/00e11463876a04a77fb97ba50c015ab9e5bee90d";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    # nixCats,
    # nix4vscode,
    #stylix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    unstablePkgs = import inputs.unstable {
      inherit system;
      config.allowUnfree = true;
      # overlays = [
      #   nix4vscode.overlays.forVscode
      # ];
    };

    stablePkgs = import inputs.stable {
      inherit system;
      config.allowUnfree = true;
    };

    sharedModules = [
      ./modules/core/configuration.nix
      home-manager.nixosModules.home-manager
      #stylix.homeManagerModules.stylix
    ];

    lastModified = toString self.lastModified;

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
              home-manager.backupFileExtension = ".hm-bkp-${lastModified}";
              home-manager.users.cristian = import ./modules/home/home.nix;
              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
              home-manager.extraSpecialArgs = {
                unstable = unstablePkgs;
                vars.hostName = name;
                nvchadModule = inputs.nix4nvchad.homeManagerModule;
                nvfpkgs = inputs.nvfpkgs;
                # nixvim = inputs.nixvim;
                stylixModule = inputs.stylix.homeManagerModules.stylix;
                # nix4vscode = inputs.nix4vscode;
                vscode_exts = inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace;
                # inherit nixCats;
              };
            }
          ];
      };
  in {
    nixosConfigurations = {
      dell-nix = mkHost "dell-nix" [./hosts/dell-nix];
      gpdp4-nix = mkHost "gpdp4-nix" [./hosts/gpdp4-nix];
    };

    # ADDED: Support for nh and tools expecting packages
    packages = {
      x86_64-linux = {
        gpdp4-nix = self.nixosConfigurations.gpdp4-nix;
        dell-nix = self.nixosConfigurations.dell-nix;

        #ADDED: default points to gpdp4-nix's system build
        #default = self.nixosConfigurations.gpdp4-nix.config.system.build.toplevel;
      };
    };

    #ADDED: For tools like nix build/run .#
    #defaultPackage.x86_64-linux = self.packages.x86_64-linux.default;
  };
}
