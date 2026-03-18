{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./vm
    ./steam
    ./greetd
    ./default-applications
    ./clamav
    ./boot-loader
    ./location
    ./silent-boot
    ./nvidia
    ./sound
    ./docker
    ./dotnet
    ./home-manager
    ./networking
  ];
}
