{ inputs, pkgs, config, ... }:

{
  imports = [
    ./virtual-box
    ./discord
    ./clamav
    ./discord
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
