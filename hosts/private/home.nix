{ config, pkgs, lib, inputs, ... }:

{
  home.username = "dabidew";
  home.homeDirectory = "/home/dabidew";

  imports =
    [ ../../modules/homeManager inputs.nixvim.homeManagerModules.nixvim ];
  modules.navi.enable = true;
  modules.awesome.enable = false;
  modules.hyprland.enable = true;
  home.packages = [ pkgs.ripgrep ];

  home.sessionVariables = {
    EDITOR = "nvim";
    LESS = "-r --mouse --wheel-lines=3";
  };
  programs.bash = { enable = true; };

  programs.git = {
    enable = true;
    userName = "dabidew";
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
