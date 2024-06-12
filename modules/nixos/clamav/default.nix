{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a 
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.clamav;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.clamav = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "clamav";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above. i
    # Options for modules imported in "imports" can be set here.

    services.clamav = {
      scanner = {
        enable = true;
        interval = "*-*-* 17:00:00";
      };
      updater.enable = true;
      daemon.enable = true;
    };
  };
}
