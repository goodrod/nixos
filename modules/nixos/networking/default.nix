{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.networking;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.networking = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [ networkmanagerapplet ];

    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;
    services.resolved = { enable = true; };
  };
}
