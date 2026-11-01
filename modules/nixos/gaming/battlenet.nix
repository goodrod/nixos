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

      # umu's own download of this runtime can fail its digest check and leave
      # an empty dir it then crashes on; Steam keeps a verified copy.
      steam_runtime="$HOME/.local/share/Steam/steamapps/common/SteamLinuxRuntime_4"
      umu_runtime="''${XDG_DATA_HOME:-$HOME/.local/share}/umu/steamrt4"
      if [ ! -f "$umu_runtime/toolmanifest.vdf" ] && [ -f "$steam_runtime/toolmanifest.vdf" ]; then
        rm -rf "$umu_runtime"
        mkdir -p "$(dirname "$umu_runtime")"
        cp -a "$steam_runtime" "$umu_runtime"
        touch "$umu_runtime/.copied-from-steam"
      fi
      if [ -f "$umu_runtime/.copied-from-steam" ]; then
        export UMU_RUNTIME_UPDATE=0
      fi

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
    icon = pkgs.fetchurl {
      url = "https://lutris.net/games/icon/battlenet.png";
      sha256 = "1an98sd6kibwlgdgai1ib8afh0n0cfczyqx0ksz1y9srvxmpvp1s";
    };
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
