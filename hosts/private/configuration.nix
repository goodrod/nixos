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
  module.discord.enable = true;
  module.hyprland.enable = true;
  module.nvidia.enable = true;
  module.steam.enable =  true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  module.greetd.enable = true;
  module.game-development.enable = true;
  module.clamav = {
    enable = true;
    on-access = {
      enable = true;
      home-directories-to-scan = [ "Downloads" "work/projects/external" "personal/projects/external" ".mozilla" ];
    };
  };
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
      "postman"
      "keymapp"
      "everdo"
      "discord"
      "nvidia-x11"
      "nvidia-settings"
      "steam-original"
      "steam"
      "steam-unwrapped-1.0.0.81"
      "steam-unwrapped"
      "aseprite"
    ];

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
    bluetuith
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  system.stateVersion = "23.11";
}
