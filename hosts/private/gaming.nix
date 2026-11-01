{ inputs, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./../../modules/nixos
    inputs.home-manager.nixosModules.default
  ];

  environment.etc.nixos-hostname.text = "private";

  boot.loader.grub.configurationName = "Gaming";

  module.gaming.enable = true;
  module.tailscale.enable = true;
  module.sunshine.enable = true;
  module.home-manager = {
    enable = true;
    module-path = ./gaming-home.nix;
  };

  programs.hyprland.enable = true;
  programs.firefox.enable = true;
  services.gvfs.enable = true;

  networking.firewall.enable = true;
  boot.kernelModules = [ "kvm-amd" ];

  boot.blacklistedKernelModules = [ "usblp" ];

  environment.systemPackages = with pkgs; [ htop ];

  system.stateVersion = "23.11";
}
