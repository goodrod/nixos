{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    optionalAttrs
    optionalString
    types
    ;
  inherit (types) bool nullOr str;
  settings = config.module.greetd;

  sessions-dir = "${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";

  greeter = ''${pkgs.tuigreet}/bin/tuigreet --time${optionalString settings.sessions " --remember --sessions ${sessions-dir}"} --cmd "${settings.command}"'';
in
{

  options.module.greetd = {
    enable = mkEnableOption "greetd";

    command = mkOption {
      type = str;
      default = "start-hyprland";
      description = "Session command tuigreet starts when nothing else is picked.";
    };

    sessions = mkOption {
      type = bool;
      default = false;
      description = ''
        Let tuigreet list the installed wayland sessions, for a host that has
        more than one worth picking between (a gamescope session next to
        Hyprland, say). Off elsewhere: with a single session the list is noise.
      '';
    };

    autologin = mkOption {
      type = nullOr str;
      default = null;
      description = ''
        User to drop straight into `command` as, skipping the greeter on the
        first login of the boot. Exiting that session still lands in tuigreet.
      '';
    };
  };

  config = mkIf settings.enable {

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = greeter;
          user = "greeter";
        };
      }
      // optionalAttrs (settings.autologin != null) {
        initial_session = {
          command = settings.command;
          user = settings.autologin;
        };
      };
    };

    # this is a life saver
    # literally no documentation about this anywhere.
    # might be good to write about this...
    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
