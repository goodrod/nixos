{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.nvidia;
in {
  options.module.nvidia = {
    enable = mkEnableOption "nvidia";
  };

  config = mkIf settings.enable {
    boot.initrd.kernelModules =
      [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

    environment.systemPackages = with pkgs; [ egl-wayland ];
    boot.kernelParams = [ "nvidia-drm.modeset=1" "fbdev=1" ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = false;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
  };
}
