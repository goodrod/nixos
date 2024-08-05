# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  module.networking.enable = true;
  module.boot-loader.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.silent-boot.enable = true;
  services.printing.enable = true;
  module.icon-fonts.enable = true;
  module.hyprland.enable = true;
  module.nvidia.enable = false;
  module.docker.enable = true;
  module.ecryptfs.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  module.dotnet.enable = true;
  module.virtual-box.enable = true;
  module.clamav = {
    enable = true;
    on-access = {
      enable = true;
      home-directories-to-scan = [ "Downloads" "work/projects/external" "personal/projects/external" ".mozilla" ];
    };
  };
  networking.hosts = {
    "192.168.0.90" = [ "host.docker.internal" ];
    "127.19.0.13" = [ "host.docker.internal" ];
    "127.19.0.1" = [ "host.docker.internal" ];
    "127.18.0.1" = [ "host.docker.internal" ];
    "127.17.0.1" = [ "host.docker.internal" ];
    "127.0.0.1" = [ "host.docker.internal" ];
    "0.0.0.0" = [ "host.docker.internal" ];
  };

  programs.firefox.enable = false;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "spotify"
      "postman"
      "keymapp"
      "everdo"
      "Oracle_VM_VirtualBox_Extension_Pack"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    xclip
    everdo
    fzf
    icu
    keymapp
    wlr-randr
    wlogout
    wget
    neovim
    git
    slack
    docker-compose
    alacritty
    mlocate
    home-manager
    bitwarden
    openconnect
    nixfmt-classic
    libnotify
    pavucontrol
    jetbrains.rider
    chromium
    openssl
    dive
    grimblast
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    xwallpaper
    spotify
    postman
    okular
    nodejs
    cryptsetup
    ntfs3g
    dunst
    libnotify
    nwg-displays
    jsonfmt
    killall
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  security.pki.certificateFiles =
    [ /home/goodrod/git-repos/Helios/misc/ca/ca/ca.pem ];
  system.stateVersion = "23.11";
}
