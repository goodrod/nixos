{ config, pkgs, lib, ... }:

{
  options.modules.navi = { enable = lib.mkEnableOption "navi"; };

  config = lib.mkIf config.modules.navi.enable {
    programs.bash = {
      bashrcExtra = ''
        eval "$(navi widget bash)"
      '';
    };

    home.packages = with pkgs; [
      navi
    ];

    home.file.".local/share/navi/cheats/work.cheat" = {
      source = ./cheats/work.cheat;
      executable = false;
    };
  };
}
