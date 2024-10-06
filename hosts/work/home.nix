{ config, pkgs, lib, inputs, ... }:

{
  module.navi.enable = true;
  module.awesome.enable = false;
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
      settings = "preferred,4480x0,1.0";
    };
  };
  module.hyprland-event-hooks.enable = true;
  module.waybar.enable = true;
  module.alacritty.enable = true;
  module.tmux.enable = true;
  module.default-home-dirs.enable = true;
  module.dunst.enable = true;
  module.wofi.enable = true;
  module.fuzzel.enable = true;
  home.packages = [ pkgs.ripgrep ];

  home.sessionVariables = {
    EDITOR = "nvim";
    LESS = "-r --mouse --wheel-lines=3";
  };
  programs.bash = { enable = true; };

  programs.git = {
    enable = true;
    userName = "goodrod";
    userEmail = "david.lindskog-hedstrom@helisoft.se";
    extraConfig = {
      init.defaultBranch = "main";
      core.pager = "less -r";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
