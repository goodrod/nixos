{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.silent-boot;
in {
  options.module.silent-boot = {
    enable = mkEnableOption "silent-boot";
  };

  config = mkIf settings.enable {
    boot.plymouth = {
      enable = true;
      theme = "breeze";
    };
  };
}
