{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.dotnet;
in
{

  options.module.dotnet = {
    enable = mkEnableOption "dotnet";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ dotnet-sdk_8 ];

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      dotnet-sdk_8
      icu
    ];
  };
}
