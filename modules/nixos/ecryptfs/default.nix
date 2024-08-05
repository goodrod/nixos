{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention. But notice how
  # option makes much more sense.
  option = config.module.ecryptfs;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.ecryptfs = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "ecryptfs";
  };

  config = mkIf option.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    environment.systemPackages = with pkgs; [ ecryptfs ];
  };
}
