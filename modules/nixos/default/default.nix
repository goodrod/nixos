{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.placeholder;
in
{

  options.module.placeholder = {
    enable = mkEnableOption "placeholder";
  };

  config = mkIf settings.enable {
    environment.systemPackages = with pkgs; [ ];
  };
}
