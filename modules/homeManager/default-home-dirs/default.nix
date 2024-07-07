{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  option = config.module.default-home-dirs;
in {
  options.module.default-home-dirs = {
    enable = mkEnableOption "default-home-dirs";
  };

  config = mkIf option.enable {
    home.file."personal/projects/internal/.keep" = {
      executable = false;
      recursive = true;
      text = "";
    };
    home.file."personal/projects/external/.keep" = {
      executable = false;
      recursive = true;
      text = "";
    };
    home.file."work/projects/external/.keep" = {
      executable = false;
      recursive = true;
      text = "";
    };
    home.file."work/projects/internal/.keep" = {
      executable = false;
      recursive = true;
      text = "";
    };
  };
}
