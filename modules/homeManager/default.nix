{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports =
    [ ./navi ./awesome ./nixvim ./hyprland ./waybar ./alacritty ./vscode ];
}
