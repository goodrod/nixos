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
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above. 
    # Options for modules imported in "imports" can be set here.
    xdg.portal.enable = true;
    xdg.portal.extraPortals =
      [ pkgs.xdg-desktop-portal-gtk ]; # needed for communication between apps
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.waybar.enable = true;

    environment.sessionVariables = {
      #WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      HYPERLAND_LOG_WLR = "1";
    };

    services.xserver = {
      enable = true;
      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --mode 2560x1440 --rotate normal --rate 144
        ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-2 --off
      '';
    };
    services.displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        sugarCandyNix = {
          enable = true; # This set SDDM's theme to "sddm-sugar-candy-nix".
          settings = {
            ScreenWidth = 2560;
            ScreenHeight = 1440;
            FormPosition = "left";
            HaveFormBackground = true;
            PartialBlur = true;
            # ...
          };
        };
      };
    };
  };
}
