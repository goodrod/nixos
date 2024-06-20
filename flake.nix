{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      # Optional, by default this flake follows nixpkgs-unstable.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.work = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/work/configuration.nix
        ./modules/nixos
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations.private = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/private/configuration.nix
        ./modules/nixos
        inputs.home-manager.nixosModules.default
        inputs.sddm-sugar-candy-nix.nixosModules.default
        {
          nixpkgs = {
            overlays = [ inputs.sddm-sugar-candy-nix.overlays.default ];
          };
        }

      ];
    };
    homeManagerModules.default = ./modules/homeManager;
  };
}
