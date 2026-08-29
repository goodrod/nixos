{
  pkgs,
  lib,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  # Modules from modules/nixos.
  module.boot-loader.enable = true;
  module.silent-boot.enable = true;
  module.networking.enable = true;
  module.tailscale.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.nvidia.enable = true;
  module.vm.enable = true;
  module.greetd.enable = true;
  module.steam.enable = true;
  module.sunshine.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./home.nix;
  };
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

  # Everything not covered by a module of its own.
  hardware.keyboard.zsa.enable = true;
  services.printing.enable = true;
  services.atd.enable = true;
  programs.firefox.enable = true;
  programs.gamescope.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc.lib ];
  networking.firewall.enable = true;
  boot.kernelModules = [ "kvm-amd" ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
    bluetuith
    keymapp
  ];

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
      "keymapp"
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

  system.stateVersion = "23.11";
}
