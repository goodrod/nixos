{ inputs, pkgs, config, ... }:

{
  imports = [
    ./tmux
    ./clamav
    ./boot-loader
    ./location
    ./silent-boot
    ./hyprland
    ./nvidia
    ./sound
    ./docker
    ./dotnet
    ./home-manager
    ./networking
    ./icon-fonts
  ];
}
