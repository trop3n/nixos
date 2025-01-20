{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    nix-colors.url = "github:misterio77/nix-colors";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix/release-24.05";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, nix-index-database, nix-colors, stylix, nvf, nur, nixvim, ... }@inputs: {

    #  packages."x86_64-linux".default =
    #   (nvf.lib.neovimConfiguration {
    #     pkgs = nixpkgs.legacyPackages."x86_64-linux";
    #     modules = [ ./nvf-configuration.nix ]; 
    #   }).neovim;

    nixosConfigurations = {
      # TODO please change the hostname to your own
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          nix-index-database.nixosModules.nix-index
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          nvf.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jason = import ./home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
