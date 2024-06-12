{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  awesomeConfig = config.module.awesome;
in {
  options.module.awesome = {
    enable = mkEnableOption "awesome";

    config-source-directory = mkOption {
      default = ./config;
      type = path;
      description =
        "Path to the directory containing the config files to output to the directory specified in the config-output-directory.";
    };

    config-output-directory = mkOption {
      default = ".config/awesome";
      type = str;
      description =
        "Path to the output directory where all config files located in the config-source-directory. Output is relative to your home directory.";
    };
  };

  config = mkIf awesomeConfig.enable {
    home.packages = with pkgs; [ awesome ];

    home.file."${awesomeConfig.config-output-directory}" = {
      source = "${awesomeConfig.config-source-directory}";
      executable = false;
      recursive = true;
    };
  };
}
