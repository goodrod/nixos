{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention. But notice how
  # option makes much more sense.
  option = config.module.default-applications;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.default-applications = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable default-applications.";
    };
  };

  config = mkIf option.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    environment.systemPackages = with pkgs; [
      alacritty
      bitwarden
      everdo
      fuzzel
      jsonfmt
      killall
      git
      wget
      grimblast
      fzf
      wlogout
      home-manager
      nixfmt-classic
      xwallpaper
      spotify
      pavucontrol
      gsimplecal
      openssl
      mlocate
      cryptsetup
      wlr-randr
      wl-clipboard
      libnotify
      icu
      ntfs3g
      unzip
      openconnect
    ];
  };
}
