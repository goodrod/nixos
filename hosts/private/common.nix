{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  module.boot-loader.enable = true;
  module.silent-boot.enable = true;
  module.networking.enable = true;
  module.location.enable = true;
  module.sound.enable = true;
  module.nvidia.enable = true;
  module.umu-runtime-watch.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
      "everdo"
      "discord"
      "discord-unwrapped"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-kernel-modules"
      "steam-original"
      "steam"
      "steam-unwrapped-1.0.0.81"
      "steam-unwrapped"
      "obsidian"
      "keymapp"
      "claude-code"
      "curseforge-unwrapped"
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
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
