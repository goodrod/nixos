{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.networking;
in {
  options.module.networking = {
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [ networkmanagerapplet ];

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;
    services.resolved = { enable = true; };
  };
}
