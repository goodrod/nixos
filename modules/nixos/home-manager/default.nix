{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # shorter name to access final settings a
  # user of hello.nix module has actually set.
  # option is a typical convention.
  option = config.module.home-manager;
  inherit (types) str path;
in {
  imports = [
    # paths to other modules.
    # compose this module out of smaller ones.
  ];

  options.module.home-manager = {
    # option declarations.
    # declare what settings a user of this module module can set.
    # usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "home-manager";
    module-path = mkOption {
      description = "path of home manager module to use.";
      type = path;
      default = ./home.nix;
    };
    username = mkOption {
      description =
        "username for account, assumes it is a single account system.";
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
    # option definitions.
    # define what other settings, services and resources should be active.
    # usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # options for modules imported in "imports" can be set here.
    users.users."${option.username}" = {
      isNormalUser = true;
      description = "${option.name}";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
    home-manager = {
      extraSpecialArgs = { inherit inputs; };
      users = {
        "${option.username}" = {
          imports = [
            "${option.module-path}"
            inputs.self.outputs.homeModules.default
            inputs.nixvim.homeModules.nixvim
          ];
          home.username = "${option.username}";
          home.homeDirectory = "/home/${option.username}";
          home.stateVersion = "23.11";
        };
      };
    };
  };
}
