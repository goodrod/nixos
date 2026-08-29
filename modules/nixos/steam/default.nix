{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.steam;
in {
  options.module.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf settings.enable {
    environment.systemPackages = with pkgs; [ ];
    programs.steam.enable = true;
  };
}
