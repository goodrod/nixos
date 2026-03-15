{
  pkgs,
  lib,
  ...
}: {
  module.navi.enable = true;
  module.hyprland = {
    enable = true;
    monitors.middle = {
      enable = true;
      name = "DP-1";
    };
    monitors.right = {
      enable = true;
      name = "HDMI-A-1";
    };
    startup-commands = [
      "dunst &"
      "hyprpaper &"
      "rider &"
      "$terminal &"
      "spotify &"
      "nm-applet &"
      "everdo &"
      "discord &"
      "waybar &"
    ];
  };
  module.waybar.enable = true;
  module.alacritty.enable = true;
  module.bash.enable = true;
  module.git-repos = {
    enable = true;
    repos = [
      { url = "https://github.com/goodrod/home-flake.git"; pushUrl = "git@github.com:goodrod/home-flake.git"; path = "personal/projects/internal/home-flake"; link = "home-flake"; }
      { url = "https://github.com/goodrod/home-configs.git"; pushUrl = "git@github.com:goodrod/home-configs.git"; path = "personal/projects/internal/home-configs"; link = "home-configs"; }
      { url = "https://github.com/goodrod/nixos.git"; pushUrl = "git@github.com:goodrod/nixos.git"; path = "personal/projects/internal/nixos"; link = "nixos"; }
    ];
  };
  module.default-home-dirs.enable = true;
  module.dunst.enable = true;
  module.wofi.enable = false;
  module.fuzzel.enable = true;
  module.obsidian.enable = true;
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
  home.stateVersion = "23.11";
}
