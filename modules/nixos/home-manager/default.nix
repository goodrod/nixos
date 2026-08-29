{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  settings = config.module.home-manager;
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

  config = mkIf settings.enable {
    nixpkgs.overlays = [ inputs.home-flake.overlays.default ];
    users.users."${settings.username}" = {
      isNormalUser = true;
      description = "${settings.name}";
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
        "${settings.username}" = {
          imports = [
            "${settings.module-path}"
            inputs.home-flake.homeModules.default
          ];
          home.username = "${settings.username}";
          home.homeDirectory = "/home/${settings.username}";
          home.stateVersion = "26.05";
        };
      };
    };
  };
}
