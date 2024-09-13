{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) path str bool;
  option = config.module.hyprland;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.hyprland = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "hyprland";

    monitors = {
      left = {
        enable = mkOption {
          type = bool;
          default = false;
        };
        name = mkOption {
          type = str;
          description = "Left monitor";
          default = "";
        };
        settings = mkOption {
          type = str;
          description = "Settings for monitor, e.g. 2560x1440@144,0x0,1.0";
          default = "preferred,0x0,1.0";
        };
      };
      middle = {
        enable = mkOption {
          type = bool;
          default = false;
        };
        name = mkOption {
          type = str;
          description = "Middle monitor";
          default = "DP-3";
        };
        settings = mkOption {
          type = str;
          description = "Settings for monitor, e.g. 2560x1440@144,0x0,1.0";
          default = "preferred,0x0,1.0";
        };
      };
      right = {
        enable = mkOption {
          type = bool;
          default = false;
        };
        name = mkOption {
          type = str;
          description = "Right monitor";
          default = "HDMI-A-2";
        };
        settings = mkOption {
          type = str;
          description = "Settings for monitor, e.g. 2560x1440@144,0x0,1.0";
          default = "preferred,2560x0,1.0";
        };
      };
    };
  };

  config = mkIf option.enable {
    #nn Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      sourceFirst = true;
      systemd.enable = true;
      xwayland.enable = true;
      settings = {
        monitor = mkMerge [
          (mkIf (option.monitors.left.enable)
            [ "${option.monitors.left.name},${option.monitors.left.settings}" ])
          (mkIf (option.monitors.middle.enable) [
            "${option.monitors.middle.name},${option.monitors.middle.settings}"
          ])
          (mkIf (option.monitors.right.enable) [
            "${option.monitors.right.name},${option.monitors.right.settings}"
          ])
          ([ "Unknown-1,disable" ])
        ];
        debug.disable_logs = false;
        "$terminal" = "alacritty";
        "$menu" = "wofi -show drun";
        "$monitor-1" = "${option.monitors.left.name}";
        "$monitor-2" = "${option.monitors.middle.name}";
        "$monitor-3" = "${option.monitors.right.name}";
        "$mainMod" = "SUPER";

        "$browserRegexp" = "firefox|Chrommium";
        "$chatRegexp" = "discord|Slack";
        "$terminalRegexp" = "Alacritty";
        "$productivityRegexp" = "everdo";
        "$musicRegexp" = ".*Spotify.*";
        "$settingsRegexp" = "com.saivert.pwvucontrol";
        "$programmingRegexp" = "code-url-handler|jetbrains-rider";
        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "workspace 1 silent,class:$settingsRegexp"
          "workspace 2 silent,title:$musicRegexp"
          "workspace 5 silent,class:$productivityRegexp"
          "workspace 6 silent,class:$chatRegexp"
          "workspace 7 silent,class:$programmingRegexp"
          "workspace 8 silent,class:$terminalRegexp"
          "workspace 9 silent,class:$browserRegexp"
        ];
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "master";
        };

	
	#render = {
	# explicit_sync = 0;
	#  explicit_sync_kms = 0;
	#};

	cursor = {
	  no_hardware_cursors = true;
	};

        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;

          "col.shadow" = "rgba(1a1a1aee)";
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        master = { new_status = "master"; };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = false;
        };

        input = {
          kb_layout = "se";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
          follow_mouse = 2;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = { natural_scroll = false; };
        };

        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures = { workspace_swipe = false; };

        exec-once = [
          "dunst &"
          "hyprpaper &"
          "slack &"
          "firefox https://www.office.com &"
          "chromium https://teams.microsoft.com/v2/ &"
          "chromium https://outlook.office.com/mail/ &"
          "rider &"
          "$terminal &"
          "spotify &"
          "nm-applet &"
          "everdo &"
          "firefox &"
        ];
        env = [ "XCURSOR_SIZE,24" "HYPRCURSOR_SIZE,24" "AQ_NO_MODIFIERS,1" ];
        bind = [
          "$mainMod, I, layoutmsg, removemaster"
          "$mainMod, O, layoutmsg, addmaster"
          "$mainMod, space, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, escape, exit,"
          "$mainMod, F, exec, $fileManager"
          "$mainMod SHIFT, F, togglefloating,"
          "$mainMod, D, exec, $menu"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, H, togglesplit, # dwindle"
          "$mainMod, A, fullscreen, 2"
          "$mainMod, code:69, focusmonitor, $monitor-1"
          "$mainMod, code:70, focusmonitor, $monitor-2"
          "$mainMod, code:71, focusmonitor, $monitor-3"
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          "$mainMod SHIFT, J, movewindow, l"
          "$mainMod SHIFT, code:47, movewindow, r"
          "$mainMod SHIFT, L, movewindow, u"
          "$mainMod SHIFT, K, movewindow, d"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, J, movefocus, l"
          "$mainMod, code:47, movefocus, r"
          "$mainMod, L, movefocus, u"
          "$mainMod, K, movefocus, d"
          "$mainMod, 1, focusworkspaceoncurrentmonitor, 1"
          "$mainMod, 2, focusworkspaceoncurrentmonitor, 2"
          "$mainMod, 3, focusworkspaceoncurrentmonitor, 3"
          "$mainMod, 4, focusworkspaceoncurrentmonitor, 4"
          "$mainMod, 5, focusworkspaceoncurrentmonitor, 5"
          "$mainMod, 6, focusworkspaceoncurrentmonitor, 6"
          "$mainMod, 7, focusworkspaceoncurrentmonitor, 7"
          "$mainMod, 8, focusworkspaceoncurrentmonitor, 8"
          "$mainMod, 9, focusworkspaceoncurrentmonitor, 9"
          "$mainMod, 0, focusworkspaceoncurrentmonitor, 10"
          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        ];
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
    programs.hyprlock.enable = true;
    services = {
      hypridle.enable = false;
      hyprpaper.enable = false;
    };
  };
}
