{ inputs, pkgs, config, ... }:

{
  imports = [
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
