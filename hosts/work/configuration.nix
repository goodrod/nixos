# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, lib, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  module.networking.enable = true;
  module.boot-loader.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.silent-boot.enable = true;
  services.printing.enable = true;
  module.icon-fonts.enable = true;
  module.nvidia.enable = false;
  module.docker.enable = true;
  module.ecryptfs.enable = true;
  module.greetd.enable = true;
  module.discord.enable = false;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  module.dotnet.enable = true;
  module.virtual-box.enable = true;
  module.clamav = {
    enable = false;
    on-access = {
      enable = false;
      home-directories-to-scan = [
        "Downloads"
        "work/projects/external"
        "personal/projects/external"
        ".mozilla"
      ];
    };
  };
  module.helios-development.enable = true;
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "rider"
      "discord"
      "spotify"
      "keymapp"
      "everdo"
      "Oracle_VM_VirtualBox_Extension_Pack"
      "Oracle_VirtualBox_Extension_Pack"
      "postman"
      "obsidian"
      "kiro-cli"
    ];

  environment.systemPackages = with pkgs; [
    ansible
    sshpass
    keyutils
    etcd_3_4
    file
    nss_latest
    slack
    pavucontrol
    (jetbrains.rider.override { jdk = pkgs.openjdk21; })
    wireguard-tools
    nodejs
    kubectl
    k9s
    kubectx
    chromium
    postman
    obsidian
    rpm
    bruno
    krb5
  ];

  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
