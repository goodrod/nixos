{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
    ./hyprland-event-hooks
    ./wofi
    ./dunst
    ./default-home-dirs
    ./navi
    ./awesome
    ./nixvim
    ./waybar
    ./alacritty
    ./vscode
    ./hyprland
    ./tmux
  ];
}
