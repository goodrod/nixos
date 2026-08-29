{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
let
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
