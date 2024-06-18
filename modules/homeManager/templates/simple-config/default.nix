{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  option = config.module.placeholder;
in {
  options.module.placeholder = {
    enable = mkEnableOption "placeholder";
    config-source-directory = mkOption {
      default = ./config;
      type = path;
      description =
        "Path to the directory containing the config files to output to the directory specified in config-output-directory.";
    };
    config-output-directory = mkOption {
      default = ".config/placeholder";
      type = str;
      description =
        "Path to the output directory where all cheat files located in the cheat-source-directory. Output is relative to your home directory.";
    };
  };

  config = mkIf option.enable {
    home.file."${option.config-output-directory}" = {
      source = "${option.config-source-directory}";
      executable = false;
      recursive = true;
    };
  };
}
