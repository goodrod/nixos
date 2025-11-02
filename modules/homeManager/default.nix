{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    ./fuzzel
    ./wofi
    ./dunst
    ./default-home-dirs
    ./navi
    ./neovim
    ./waybar
    ./alacritty
    ./hyprland
  ];
}
