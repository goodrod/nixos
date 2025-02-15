{ config, pkgs, lib, ... }:
with lib;
let
  option = config.module.clamav;
  all-normal-users =
    attrsets.filterAttrs (username: config: config.isNormalUser)
    config.users.users;
  all-sus-dirs = builtins.concatMap (dir:
    attrsets.mapAttrsToList (username: config: config.home + "/" + dir)
    all-normal-users) option.on-access.home-directories-to-scan;
  all-user-folders =
    attrsets.mapAttrsToList (username: config: config.home) all-normal-users;
  all-system-folders = [ "/boot" "/etc" "/nix" "/opt" "/root" "/usr" ];
  notify-all-users = pkgs.writeScript "notify-all-users-of-sus-file" ''
    #!/bin/sh
    ALERT="Signature detected by ClamAV: $CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"
    # Send an alert to all graphical users.
    for ADDRESS in /run/user/*; do
        USERID=''${ADDRESS#/run/user/}
       /run/wrappers/bin/sudo -u "#$USERID" DBUS_SESSION_BUS_ADDRESS="unix:path=$ADDRESS/bus" ${pkgs.libnotify}/bin/notify-send -i dialog-warning "$ALERT"
    done
  '';
in {
  options = {
    module.clamav = {
      enable = mkEnableOption "clamav";
      on-access = {
        enable = mkEnableOption "on-access";
        home-directories-to-scan = mkOption {
          type = types.listOf types.str;
          default = [ "Downloads" ".mozilla" ];
        };
      };
    };
  };

  config = mkIf option.enable {
    security.sudo = {
      extraConfig = ''
        clamav ALL = (ALL) NOPASSWD: SETENV: ${pkgs.libnotify}/bin/notify-send
      '';
    };

    services.clamav.daemon = {
      enable = true;

      settings = {
        OnAccessIncludePath = all-sus-dirs;
        OnAccessPrevention = true;
        OnAccessExtraScanning = true;
        OnAccessExcludeUname = "clamav";
        VirusEvent = "${notify-all-users}";
        User = "clamav";
      };
    };
    services.clamav.updater.enable = true;

    systemd.services.clamav-clamonacc = mkIf option.on-access.enable {
      description = "ClamAV daemon (clamonacc)";

      after = [ "clamav-freshclam.service" "clamav-daemon.service" ];
      wantedBy = [ "multi-user.target" ];
      restartTriggers = [ "/etc/clamav/clamd.conf" ];

      serviceConfig = {
        Type = "simple";
        ExecStartPre = ''
          ${pkgs.bash}/bin/bash -c "while [ ! -S /run/clamav/clamd.ctl  ]; do sleep 1; done"'';
        ExecStart =
          "${pkgs.systemd}/bin/systemd-cat --identifier=av-scan ${pkgs.clamav}/bin/clamonacc -F --fdpass";
        PrivateTmp = "yes";
        PrivateDevices = "yes";
        PrivateNetwork = "yes";
      };
    };
  };
}
