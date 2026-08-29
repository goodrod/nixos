{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.sound;
in {
  options.module.sound = {
    enable = mkEnableOption "sound";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ pulsemixer bluetuith ];
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = { Policy = { AutoEnable = "true"; }; };
    };
  };
}
