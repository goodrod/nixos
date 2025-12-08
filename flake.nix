{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
        type = "github";
        host = "github.com";
        owner = "goodrod";
        repo = "nvim";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprlauncher = { url = "github:hyprwm/hyprlauncher"; };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let libx = import ./lib { inherit inputs; };
    in {
      nixosConfigurations = nixpkgs.lib.attrsets.genAttrs [ "work" "private" "private-2" ]
      (name: libx.mkHost { hostname = name; });
      homeModules.default = ./modules/homeManager;
    };
}
