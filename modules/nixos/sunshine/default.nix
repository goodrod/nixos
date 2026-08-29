{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  settings = config.module.sunshine;
in
{

  options.module.sunshine = {
    enable = mkEnableOption "sunshine";
  };

  config = mkIf settings.enable {
    users.users.${config.module.home-manager.username}.extraGroups = [
      "input"
      "uinput"
    ];
    networking.firewall = {
      allowedTCPPorts = [
        47984
        47989
        47990
        48010
      ];
      allowedUDPPortRanges = [
        {
          from = 47998;
          to = 48000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
      capSysAdmin = true;
    };
  };
}
