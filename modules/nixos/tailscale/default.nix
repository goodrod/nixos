{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.tailscale;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.tailscale = {
    enable = mkEnableOption "tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;

    # Traffic on tailscale0 is already authenticated/encrypted by the mesh VPN
    # itself - trusting the interface here is what lets a peer actually reach a
    # service (e.g. tinymmo's gateway) bound on this host without punching
    # per-port holes in networking.firewall for every project that wants this.
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
