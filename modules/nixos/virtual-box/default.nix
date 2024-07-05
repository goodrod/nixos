{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention. But notice how
  # option makes much more sense.
  option = config.module.virtual-box;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.virtual-box = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "virtual-box";
  };

  config = mkIf option.enable {
    users.users.goodrod.extraGroups = [ "vboxusers" ];
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.guest.clipboard = true;
    virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
  };
}
