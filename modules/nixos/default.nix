{ inputs, pkgs, config, ... }:

{
  imports = [
    ./vm
    ./kiro
    ./game-development
    ./steam
    ./greetd
    ./helios-development
    ./default-applications
    ./ecryptfs
    ./virtual-box
    ./discord
    ./clamav
    ./discord
    ./boot-loader
    ./location
    ./silent-boot
    ./nvidia
    ./sound
    ./docker
    ./dotnet
    ./home-manager
    ./networking
    ./icon-fonts
  ];
}
