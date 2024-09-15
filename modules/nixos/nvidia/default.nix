{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.nvidia;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.nvidia = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "nvidia";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported& in "imports" can be set here.
    boot.kernelModules = [
     "nvidia"
     "nvidia_drm"
     "nvidia_modeset"
     "nvidia_uvm"
    ];
    boot.kernelParams = [
     "nvidia_drm.fbdev=1"
     "nvidia_drm.modeset=1"
     "module_blacklist=i915"
    ];
    environment.systemPackages = with pkgs; [
      egl-wayland
    ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      graphics.enable = true;
      nvidia = {
        open = false;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "555.58";
          sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
          sha256_aarch64 = lib.fakeSha256;
          openSha256 = lib.fakeSha256;
          settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
          persistencedSha256 = lib.fakeSha256;
        };
      };
    };
  };
}
