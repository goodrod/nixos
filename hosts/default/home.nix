{ config, pkgs, lib, ... }:

{
  home.username = "goodrod";
  home.homeDirectory = "/home/goodrod";

  imports = [ ../../modules/default.nix ];
  modules.navi.enable = true;
  home.packages = [ ];

  home.sessionVariables = { EDITOR = "nvim"; };
  programs.bash = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "goodrod";
    userEmail = "david.lindskog-hedstrom@helisoft.se";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
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
