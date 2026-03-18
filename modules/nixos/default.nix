{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./vm
    ./kiro
    ./game-development
    ./steam
    ./greetd
    ./default-applications
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
