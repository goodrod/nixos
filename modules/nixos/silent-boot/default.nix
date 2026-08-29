{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.silent-boot;
in {
  options.module.silent-boot = {
    enable = mkEnableOption "silent-boot";
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      theme = "breeze";
    };
  };
}
