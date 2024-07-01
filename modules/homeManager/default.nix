{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";
  imports = [
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
