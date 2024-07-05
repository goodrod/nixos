{ inputs, pkgs, config, ... }:

{
  imports = [
    ./virtual-box
    ./discord
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
