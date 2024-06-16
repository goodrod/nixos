# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ ./hardware-configuration.nix inputs.home-manager.nixosModules.default ];

  module.defaults.enable = true;
  module.location.enable = true;
  module.clamav.enable = true;
  module.boot-loader.enable = true;
  module.silent-boot.enable = true;
  module.hyprland.enable = true;
  module.nvidia.enable = true;
  module.sound.enable = true;
  module.docker.enable = true;
  module.dotnet.enable = true;
  module.networking.enable = true;
  module.icon-fonts.enable = true;
  services.printing.enable = true;


  # TODO: keep here?
  programs.firefox.enable = false;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "spotify"
      "postman"
      "keymapp"
      "everdo"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    clamav
    keymapp
    wget
    neovim
    git
    docker-compose
    alacritty
    mlocate
    home-manager
    bitwarden
    openconnect
    nixfmt-classic
    libnotify
    slack
    pavucontrol
    jetbrains.rider
    chromium
    openssl
    flameshot
    dive
    dotnet-sdk_8
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    xwallpaper
    spotify
    postman
    okular
    kitty
    nodejs
    cryptsetup
    ntfs3g
    dunst
    libnotify
    rofi-wayland
    nwg-displays
    dolphin
    jsonfmt
  ];
 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
