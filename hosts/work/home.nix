{ pkgs, lib, ... }:

{
  module.navi.enable = true;
  module.hyprland = {
    enable = true;
    monitors.left = {
      name = "eDP-1";
      enable = true;
    };
    monitors.middle = {
      enable = true;
      name = "DP-5";
      settings = "preferred,1920x0,1.0";
    };
    monitors.right = {
      enable = true;
      name = "DP-6";
      settings = "1920x1080@60,4480x0,1.0";
    };
    startup-commands = [
      "dunst &"
      "hyprpaper &"
      "slack &"
      "chromium-browser --app=https://teams.microsoft.com/v2/ &"
      "chromium-browser --app=https://outlook.office.com/mail/ &"
      "rider &"
      "$terminal &"
      "spotify &"
      "nm-applet &"
      "everdo &"
      "waybar &"
    ];
  };
  module.waybar.enable = true;
  module.alacritty.enable = true;
  module.bash.enable = true;
  module.git-repos = {
    enable = true;
    repos = [
      { url = "git@github.com:goodrod/home-flake.git"; path = "git-repos/home-flake"; }
      { url = "git@github.com:goodrod/home-configs.git"; path = "git-repos/home-configs"; }
      { url = "git@github.com:goodrod/nixos.git"; path = "git-repos/nixos"; }
    ];
  };
  module.default-home-dirs.enable = true;
  module.dunst.enable = true;
  module.wofi.enable = true;
  module.fuzzel.enable = true;
  module.default-applications.enable = true;
  home.packages = [ pkgs.ripgrep ];

  home.sessionVariables = {
    EDITOR = "nvim";
    LESS = "-r --mouse --wheel-lines=3";
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "goodrod";
        email = "david.lindskog-hedstrom@helisoft.se";
      };
      init.defaultBranch = "main";
      core.pager = "less -r";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
