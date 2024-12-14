{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.hyprland;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.hyprland = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "hyprland";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ papirus-icon-theme ];
    programs.waybar.enable = true;
    programs.hyprland.enable = true;
    hardware.graphics.enable32Bit = true;
    programs.hyprland.package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    programs.hyprland.portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    environment.sessionVariables = {
      #WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      HYPERLAND_LOG_WLR = "1";
    };
  };
}
