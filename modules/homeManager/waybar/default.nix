{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  waybarConfig = config.module.waybar;
in {
  options.module.waybar = {
    enable = mkEnableOption "waybar";

    config-source-directory = mkOption {
      default = ./config;
      type = path;
      description =
        "Path to the directory containing the config files to output to the directory specified in the config-output-directory.";
    };

    config-output-directory = mkOption {
      default = ".config/waybar";
      type = str;
      description =
        "Path to the output directory where all config files located in the config-source-directory. Output is relative to your home directory.";
    };
  };

  config = mkIf waybarConfig.enable {
    home.packages = with pkgs; [ waybar ];

    home.file."${waybarConfig.config-output-directory}" = {
      source = "${waybarConfig.config-source-directory}";
      executable = false;
      recursive = true;
    };
  };
}
