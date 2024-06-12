{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  hyprlandConfig = config.module.hyprland;
in {
  options.module.hyprland = {
    enable = mkEnableOption "hyprland";

    config-source-directory = mkOption {
      default = ./config;
      type = path;
      description =
        "Path to the directory containing the config files to output to the directory specified in the config-output-directory.";
    };

    config-output-directory = mkOption {
      default = ".config/hypr";
      type = str;
      description =
        "Path to the output directory where all config files located in the config-source-directory. Output is relative to your home directory.";
    };
  };

  config = mkIf hyprlandConfig.enable {
    home.file."${hyprlandConfig.config-output-directory}" = {
      source = "${hyprlandConfig.config-source-directory}";
      executable = false;
      recursive = true;
    };
  };
}
