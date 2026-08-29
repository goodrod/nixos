{ config, pkgs, lib, inputs, ... }:
with lib;
let
  option = config.module.steam;
in {
  options.module.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf option.enable {
    environment.systemPackages = with pkgs; [ ];
    programs.steam.enable = true;
  };
}
