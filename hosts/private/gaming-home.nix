{ lib, pkgs, ... }:
{
  module.hyprland = {
    enable = true;
    autostart-from-tty = true;
    screenshot-editor-workspace = 50;
    monitors.middle = {
      name = "DP-1";
      workspace = 20;
      focusKey = "comma";
      pinnedWorkspaces = [ 10 ];
      exclusiveWorkspace = 10;
    };
    monitors.right = {
      name = "HDMI-A-1";
      settings = "preferred,2560x0,1.0";
      workspace = 30;
      focusKey = "period";
    };
    features = {
      categoryWorkspaces.enable = true;
      workspaceGrid.enable = true;
    };
    keys = {
      screenshot = "P";
      screenshotMonitor = "SHIFT + P";
      record = "R";
      exit = "SHIFT + Delete";
    };
    startup-commands = [
      "steam -silent"
      "discord"
    ];
    luaConfig = lib.mkAfter ''
      hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus --new-window"), { description = "File manager" })

      hl.on("window.open", function(w)
        if w == nil or w.class == nil then return end
        if w.class:match("^steam_app_") or w.class == "gamescope" then
          hl.dispatch(hl.dsp.focus({ window = "address:" .. w.address }))
        end
      end)
    '';
  };
  module.workspaces.entries = {
    games = {
      id = 10;
      icon = "󰊴";
      persistent = true;
      match.class = "steam_app_.*|gamescope";
    };
    music = {
      id = 20;
      icon = "󰎆";
      persistent = true;
      match.title = ".*Spotify.*";
    };
    launchers = {
      id = 30;
      icon = "󰊗";
      persistent = true;
      match = {
        class = "steam|heroic|net.lutris.Lutris|lutris|org.prismlauncher.PrismLauncher|com.usebottles.bottles|itch";
        title = "Battle.net";
      };
    };
    tools = {
      id = 50;
      icon = "󱁤";
    };
    mail = {
      id = 40;
      icon = "󰇮";
      persistent = true;
      match.class = "chrome-mail.google.com.*|chrome-calendar.google.com.*";
    };
    chat = {
      id = 60;
      icon = "󰭹";
      persistent = true;
      match = {
        class = "discord|vesktop";
        initialTitle = "discord|vesktop";
      };
    };
    term = {
      id = 80;
      icon = "󰆍";
      match.class = "Alacritty";
    };
    browser = {
      id = 90;
      icon = "󰈹";
      persistent = true;
      match.class = "firefox_firefox|firefox|Chromium";
    };
  };
  module.quickshell.enable = true;
  module.swaync.enable = false;
  module.dunst.enable = false;
  module.hyprpaper.enable = true;
  module.wlogout.enable = true;
  module.spotify.enable = true;
  module.discord.enable = true;
  module.steam-games-menu.enable = true;
  module.alacritty.enable = true;
  module.bash.enable = true;
  module.fuzzel = {
    enable = true;
    hidden = [
      "nixos-manual"
      "nm-connection-editor"
      "htop"
      "qt6ct"
      "nvidia-settings"
    ];
  };
  module.bluetooth.enable = true;
  module.icon-fonts.enable = true;

  home.packages = [ pkgs.nautilus ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
  };

  programs.home-manager.enable = true;
}
