{ config, pkgs, lib, inputs, ... }:
with lib;
let
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
