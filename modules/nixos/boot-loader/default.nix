{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.boot-loader;
in {
  options.module.boot-loader = {
    enable = mkEnableOption "boot-loader";
  };

  config = mkIf settings.enable {
    boot.loader.grub = {
      enable = true;
      useOSProber = true;
      device = "nodev";
      efiSupport = true;
      default = "saved";

    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
