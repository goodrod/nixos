{
  module.hyprland = {
    enable = true;
    autostart-from-tty = true;
    monitors.middle = {
      name = "DP-1";
      workspace = 20;
      focusKey = "F4";
    };
    monitors.right = {
      name = "HDMI-A-1";
      settings = "preferred,2560x0,1.0";
      workspace = 30;
      focusKey = "F5";
    };
    # A light desktop: none of module.hyprland.features (workspace and task
    # management), only the shared notification/launcher/lock QoL.
    startup-commands = [ "steam -silent" ];
  };
  # Quickshell owns notifications (its control center), so swaync and dunst
  # stay off to not race it for the org.freedesktop.Notifications name.
  module.quickshell = {
    enable = true;
    variant = "gaming";
  };
  module.swaync.enable = false;
  module.dunst.enable = false;
  module.hyprpaper.enable = true;
  module.wlogout.enable = true;
  module.alacritty.enable = true;
  module.bash.enable = true;
  module.fuzzel.enable = true;
  module.bluetooth.enable = true;
  module.icon-fonts.enable = true;

  programs.home-manager.enable = true;
}
