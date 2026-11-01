{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.umu-runtime-watch;

  check = pkgs.writeShellApplication {
    name = "umu-runtime-watch";
    runtimeInputs = with pkgs; [
      coreutils
      curl
      gnugrep
    ];
    text = builtins.readFile ./check.sh;
  };
in
{
  options.module.umu-runtime-watch = {
    enable = mkEnableOption ''
      a daily check for Valve fixing the Steam Linux Runtime 4 checksums umu
      downloads against, with a desktop notification once it has. Remove
      together with the battlenet runtime workaround'';
  };

  config = mkIf settings.enable {
    systemd.user.services.umu-runtime-watch = {
      description = "Check whether Valve's steamrt4 checksums match again";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${check}/bin/umu-runtime-watch";
      };
    };

    systemd.user.timers.umu-runtime-watch = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        OnStartupSec = "10min";
        Persistent = true;
      };
    };
  };
}
