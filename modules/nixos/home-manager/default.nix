{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  option = config.module.home-manager;
  inherit (types) str path;
in
{
  options.module.home-manager = {
    enable = mkEnableOption "home-manager";
    module-path = mkOption {
      description = "path of home manager module to use.";
      type = path;
      default = ./home.nix;
    };
    username = mkOption {
      description = "username for account, assumes it is a single account system.";
      type = str;
      default = "goodrod";
    };
    name = mkOption {
      description = "real name of user";
      type = str;
      default = "david lindskog hedström";
    };
  };

  config = mkIf option.enable {
    nixpkgs.overlays = [ inputs.home-flake.overlays.default ];
    users.users."${option.username}" = {
      isNormalUser = true;
      description = "${option.name}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users = {
        "${option.username}" = {
          imports = [
            "${option.module-path}"
            inputs.home-flake.homeModules.default
          ];
          home.username = "${option.username}";
          home.homeDirectory = "/home/${option.username}";
          home.stateVersion = "26.05";
        };
      };
    };
  };
}
