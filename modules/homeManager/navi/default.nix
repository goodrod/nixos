{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  option = config.module.navi;
in {
  options.module.navi = {
    enable = mkEnableOption "navi";

    config-source-directory = mkOption {
      default = ./config;
      type = path;
      description =
        "Path to the directory containing the config files to output to the directory specified in config-output-directory.";
    };
    config-output-directory = mkOption {
      default = ".config/navi/";
      type = str;
      description =
        "Path to the output directory where all config files located in the config-source-directory. Output is relative to your home directory.";
    };
    cheats-source-directory = mkOption {
      default = ./cheats;
      type = path;
      description =
        "Path to the directory containing the cheat files to output to the directory specified in cheat-output-directory.";
    };
    cheats-output-directory = mkOption {
      default = ".local/share/navi/cheats";
      type = str;
      description =
        "Path to the output directory where all cheat files located in the cheat-source-directory. Output is relative to your home directory.";
    };
  };

  config = mkIf option.enable {
    programs.bash = {
      bashrcExtra = ''
        eval "$(navi widget bash)"
      '';
    };

    home.packages = with pkgs; [ navi ];

    home.file."${option.cheats-output-directory}" = {
      source = "${option.cheats-source-directory}";
      executable = false;
      recursive = true;
    };
    home.file."${option.config-output-directory}" = {
      source = "${option.config-source-directory}";
      executable = false;
      recursive = true;
    };
  };
}
