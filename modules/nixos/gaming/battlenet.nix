{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf mkOption types;
  settings = config.module.gaming.battlenet;

  battlenet = pkgs.writeShellApplication {
    name = "battlenet";
    runtimeInputs = with pkgs; [
      umu-launcher
      curl
    ];
    text = ''
      prefix="''${BATTLENET_PREFIX:-$HOME/${settings.prefix}}"
      export WINEPREFIX="$prefix"
      export GAMEID=umu-battlenet
      export STORE=battlenet
      export PROTONPATH=${pkgs.proton-ge-bin.steamcompattool}

      launcher="$prefix/drive_c/Program Files (x86)/Battle.net/Battle.net Launcher.exe"
      if [ ! -f "$launcher" ]; then
        mkdir -p "$prefix"
        setup="$prefix/Battle.net-Setup.exe"
        curl -fL -o "$setup" "https://downloader.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe"
        umu-run "$setup"
      fi
      exec umu-run "$launcher"
    '';
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "battlenet";
    desktopName = "Battle.net";
    exec = "battlenet";
    icon = "applications-games";
    categories = [ "Game" ];
  };
in
{
  options.module.gaming.battlenet = {
    enable = mkEnableOption "Battle.net under umu-launcher and Proton-GE, installed into its own prefix on first run";

    prefix = mkOption {
      type = types.str;
      default = "Games/battlenet";
      description = "Wine prefix, relative to the home directory. BATTLENET_PREFIX overrides it at runtime.";
    };
  };

  config = mkIf settings.enable {
    environment.systemPackages = [
      battlenet
      desktopItem
    ];
  };
}
