{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  settings = config.module.default-applications;
in
{

  options.module.default-applications = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable default-applications.";
    };
  };

  config = mkIf settings.enable {
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    services.spotifyd.enable = false;
    programs.dconf.enable = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    environment.systemPackages = with pkgs; [
      mlocate
      cryptsetup
      ntfs3g
      openconnect
      gh
    ];
  };
}
