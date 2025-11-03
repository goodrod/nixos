{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preview-nvim-plugin = {
      url = "gitlab:itaranto/preview.nvim";
      flake = false;
    };

    gp-nvim-plugin = {
      url = "github:Robitx/gp.nvim";
      flake = false;
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlauncher = {
      url = "github:hyprwm/hyprlauncher";
    };
    
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let libx = import ./lib { inherit inputs; };
    in {
      nixosConfigurations =
        nixpkgs.lib.attrsets.genAttrs [ "work" "private" "private-2" ]
        (name: libx.mkHost { hostname = name; });
      homeModules.default = ./modules/homeManager;
    };
}
