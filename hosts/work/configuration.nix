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
  module.greetd.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  module.dotnet.enable = true;
  module.virtual-box.enable = false;
  module.clamav = {
    enable = true;
    on-access = {
      enable = true;
      home-directories-to-scan = [ "Downloads" "work/projects/external" "personal/projects/external" ".mozilla" ];
    };
  };
  module.helios-development.enable = true;
  programs.firefox.enable = false;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "spotify"
      "keymapp"
      "everdo"
      "Oracle_VM_VirtualBox_Extension_Pack"
      "postman"
      "obsidian"
    ];

  # list packages installed in system profile. to search, run:
  environment.systemPackages = with pkgs; [
    ansible
    sshpass
    keyutils
    file
    nss_latest
    slack
    pavucontrol
    jetbrains.rider
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    nodejs
    kubectl
    k9s
    kubectx
    chromium
    postman
    obsidian
    rpm
  ];


  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
