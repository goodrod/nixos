{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention. But notice how
  # option makes much more sense.
  option = config.module.sunshine;
in
{
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.sunshine = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "sunshine";
  };

  config = mkIf option.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    environment.systemPackages = with pkgs; [ ];
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
