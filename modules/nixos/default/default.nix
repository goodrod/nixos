{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  option = config.module.placeholder;
in
{

  options.module.placeholder = {
    enable = mkEnableOption "placeholder";
  };

  config = mkIf option.enable {
    environment.systemPackages = with pkgs; [ ];
  };
}
