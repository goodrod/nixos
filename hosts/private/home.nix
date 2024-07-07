{ config, pkgs, lib, inputs, ... }:

{
  module.navi.enable = true;
  module.awesome.enable = false;
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
  };
  module.waybar.enable = true;
  module.alacritty.enable = true;
  module.vscode.enable = true;
  module.tmux.enable = true;
  module.default-home-dirs.enable = true;
  module.dunst.enable = true;
  module.wofi.enable = true;
  home.packages = [ pkgs.ripgrep ];

  home.sessionVariables = {
    EDITOR = "nvim";
    LESS = "-r --mouse --wheel-lines=3";
  };
  programs.bash = { enable = true; };

  programs.git = {
    enable = true;
    userName = "goodrod";
    userEmail = "david.lindskog.hedstrom@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      core.pager = "less -r";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
