{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "23.11";

  imports = [
    ./fuzzel
    ./hyprland-event-hooks
    ./wofi
    ./dunst
    ./default-home-dirs
    ./navi
    ./awesome
    ./neovim
    ./waybar
    ./alacritty
    ./vscode
    ./hyprland
    ./tmux
  ];
}
