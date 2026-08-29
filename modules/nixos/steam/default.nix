{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.steam;
in {
  options.module.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf settings.enable {
    programs.steam.enable = true;
  };
}
