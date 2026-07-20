{
  pkgs,
  lib,
  ...
}: {
  module.navi.enable = true;
  module.hyprland = {
    enable = true;
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
    startup-commands = [
      "rider &"
      "$terminal &"
      "spotify &"
      "nm-applet &"
      "everdo &"
      "discord &"
    ];
  };
  module.waybar.enable = false;
  module.quickshell.enable = true;
  module.alacritty.enable = true;
  module.bash.enable = true;
  module.git-repos = {
    enable = true;
    repos = [
      { url = "git@github.com:goodrod/home-flake.git"; path = "personal/projects/internal/home-flake"; link = "home-flake"; }
      { url = "git@github.com:goodrod/home-configs.git"; path = "personal/projects/internal/home-configs"; link = "home-configs"; }
      { url = "git@github.com:goodrod/nixos.git"; path = "personal/projects/internal/nixos"; link = "nixos"; }
    ];
  };
  module.default-home-dirs.enable = true;
  module.dunst.enable = false;
  # Quickshell's bar now owns notifications directly (Quickshell.Services.
  # Notifications.NotificationServer, see modules/quickshell/config/
  # NotificationCenter.qml) - swaync stays off so it doesn't race quickshell
  # for the org.freedesktop.Notifications DBus name.
  module.swaync.enable = false;
  module.hyprpaper.enable = true;
  module.wlogout.enable = true;
  module.fuzzel.enable = true;
  module.obsidian.enable = true;
  module.discord.enable = true;
  module.game-development.enable = true;
  module.kiro.enable = true;
  module.icon-fonts.enable = true;
  module.spotify.enable = true;
  module.bluetooth.enable = true;
  module.personal-apps.enable = true;
  module.default-applications.enable = true;
  home.packages = [pkgs.ripgrep];

  home.sessionPath = ["/home/goodrod/.local/bin"];
  home.sessionVariables = {
    EDITOR = "nvim";
    LESS = "-r --mouse --wheel-lines=3";
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "goodrod";
        email = "david.lindskog.hedstrom@pm.me";
      };
      init.defaultBranch = "main";
      core.pager = "less -r";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
