{
  inputs,
  lib,
  ...
}: let
  mkPkgs = system: import inputs.nixpkgs {inherit system;};

  hyprlandProfile = {...}: {
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

  mkHomeConfig = username:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = mkPkgs "x86_64-linux";
      extraSpecialArgs = {inherit inputs;};
      modules = [
        inputs.self.homeModules.default
        hyprlandProfile
        inputs.nixvim.homeModules.nixvim
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "23.11";
        }
      ];
    };
in {
  flake.homeModules.default = import ../modules/homeManager;

  flake.homeConfigurations = {
    goodrod = mkHomeConfig "goodrod";
    calle = mkHomeConfig "calle";
    david = mkHomeConfig "david";
  };
}
