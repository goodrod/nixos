{ inputs, lib, ... }:
let
  mkPkgs = system: import inputs.nixpkgs { inherit system; };

  goodrodProfile = { ... }: {
    module = {
      alacritty.enable = true;
      fuzzel.enable = true;
      wofi.enable = true;
      dunst.enable = true;
      default-home-dirs.enable = true;
      navi.enable = true;
      waybar.enable = true;
      hyprland.enable = true;
      obsidian.enable = false;
    };
  };
in {
  flake.homeModules.default = import ../modules/homeManager;

  flake.homeConfigurations.goodrod =
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs "x86_64-linux";
      extraSpecialArgs = { inherit inputs; };
      modules = [
        inputs.self.homeModules.default
        goodrodProfile
        inputs.nixvim.homeModules.nixvim
        {
          home.username = "goodrod";
          home.homeDirectory = "/home/goodrod";
          home.stateVersion = "23.11";
        }
      ];
    };
}

