# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];
  module.vm.enable = true;
  module.networking.enable = true;
  module.boot-loader.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.silent-boot.enable = true;
  services.printing.enable = true;
  module.nvidia.enable = true;
  module.steam.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
  programs.gamescope.enable = true;
  module.greetd.enable = true;
  module.sunshine.enable = true;
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
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
      "everdo"
      "discord"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-kernel-modules"
      "steam-original"
      "steam"
      "steam-unwrapped-1.0.0.81"
      "steam-unwrapped"
      "aseprite"
      "kiro"
      "obsidian"
    ];
  environment.systemPackages = with pkgs; [
    wireguard-tools
    bluetuith
  ];
  nix.extraOptions = ''
    !include /etc/nix/access-tokens.conf
  '';
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkogY9T/mvf4w7OxljEK4="
    ];
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc.lib ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  boot.kernelModules = [ "kvm-amd" ];
  system.stateVersion = "23.11";
}
