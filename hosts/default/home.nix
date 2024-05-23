{ config, pkgs, lib, ... }:

{
  home.username = "goodrod";
  home.homeDirectory = "/home/goodrod";

  imports = [ ../../modules/default.nix ];
  modules.navi.enable = true;
  modules.awesome.enable = true;
  home.packages = [ ];

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
      safe.directory = "/etc/nixos";
      core.pager = "less -r";
    };
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
