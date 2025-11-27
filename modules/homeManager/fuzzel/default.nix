{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.fuzzel;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.fuzzel = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "fuzzel";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          font = "Hack Nerd Font:size=12"; # Monospaced font
          width = 50; # Width option
          lines = 20;
          horizontal-pad = 20; # Horizontal padding
          vertical-pad = 8; # Vertical padding
          inner-pad = 5; # Inner padding
          dpi-aware = "yes";
        };
        border = {
          width = 2; # Border width
          radius = 10; # Border radius
        };
        colors = {
          background = "#1e1e2eff"; # Dark background
          text = "#cdd6f4ff"; # Light text
          prompt = "#ff8c00ff"; # Orange prompt
          placeholder = "#93a1a1ff"; # Light placeholder
          input = "#cdd6f4ff"; # Light input text
          match = "#00ff00ff"; # Match color (same as prompt)
          selection = "#313244ff"; # Darker selection background
          selection-text = "#ff8c00ff"; # Selected text matches prompt
          selection-match = "#00ff00ff"; # Match color in selected text
          counter = "#93a1a1ff"; # Counter color
          border = "#1e1e2eff"; # Border col r
        };
      };
    };
    xdg.desktopEntries.teams = {
      name = "Microsoft Teams";
      comment = "Microsoft Teams via Vivaldi";
      exec = ''
        ${pkgs.chromium}/bin/chromium-browser --app=https://teams.microsoft.com
      '';
      icon = "teams";
      terminal = false;
      categories = [ "Network" "Office" ];
    };

    xdg.desktopEntries.outlook = {
      name = "Outlook";
      comment = "Microsoft Outlook via Vivaldi";
      exec = ''
        ${pkgs.chromium}/bin/chromium-browser --app=https://outlook.office.com/mail
      '';
      icon = "outlook";
      terminal = false;
      categories = [ "Network" "Office" ];
    };
  };
}
