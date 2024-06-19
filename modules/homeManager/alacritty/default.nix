{ config, pkgs, lib, ... }:

let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str;
  option = config.module.alacritty;
in {
  options.module.alacritty = { enable = mkEnableOption "alacritty"; };

  config = mkIf option.enable {
    programs.alacritty = {
      enable = true;
      settings = { window.opacity = 0.8; };
    };
  };
}
