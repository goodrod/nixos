{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    ./obsidian
    ./fuzzel
    ./wofi
    ./dunst
    ./default-home-dirs
    ./navi
    ./waybar
    ./alacritty
    ./hyprland
  ];
}
