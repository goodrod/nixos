{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.default-applications;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.default-applications = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "default-applications";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    home.packages = with pkgs; [
      plantuml
      alacritty
      bitwarden-desktop
      jq
      everdo
      fuzzel
      jsonfmt
      killall
      git
      wget
      fzf
      wlogout
      nixfmt-classic
      xwallpaper
      spotify
      pavucontrol
      gsimplecal
      openssl
      wlr-randr
      wl-clipboard
      libnotify
      icu
      unzip
      traceroute
      htop
      atop
      spotify-player
      chatgpt-cli
      slurp
      swappy
      grim
      tree
      inputs.nvim.packages.${pkgs.stdenv.system}.nvim
    ];
  };
}
