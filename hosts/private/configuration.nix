# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, lib, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  module.vm.enable = true;
  module.networking.enable = true;
  module.boot-loader.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.silent-boot.enable = true;
  services.printing.enable = true;
  module.icon-fonts.enable = true;
  module.discord.enable = true;
  module.nvidia.enable = true;
  module.steam.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  programs.gamescope.enable = true;
  module.greetd.enable = true;
  module.game-development.enable = true;
  module.kiro.enable = true;
  module.clamav = {
    enable = true;
    on-access = {
      enable = true;
      home-directories-to-scan = [
        "Downloads"
        "work/projects/external"
        "personal/projects/external"
        ".mozilla"
      ];
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
      "kiro"
      "kiro-cli"
      "obsidian"
    ];
  environment.systemPackages = with pkgs; [ wireguard-tools bluetuith ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc.lib ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  boot.kernelModules = [ "kvm-amd" ];
  system.stateVersion = "23.11";
}
