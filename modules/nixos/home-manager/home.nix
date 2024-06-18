{ config, pkgs, lib, inputs, ... }:

{
  home.username = "goodrod";
  home.homeDirectory = "/home/goodrod";

  imports = [
    inputs.self.outputs.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
  ];
  module.navi.enable = true;
  module.awesome.enable = false;
  module.hyprland.enable = true;
  module.waybar.enable = true;
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
      safe.directory = "/etc/nixos";
      core.pager = "less -r";
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
