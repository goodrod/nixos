{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.wofi;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.wofi = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "wofi";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    programs.wofi = {
      enable = true;
      settings = {
        width = 800;
        height = 400;
        location = "center";
        text = "Search...";
        show = "drun";
        filter_rate = 100;
        allow_markup = true;
        insensitive = true;
        allow_images = true;
        image_size = 28;
        gtk_dark = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
      };
      style = ''
                @define-color clear rgba(0, 0, 0, 0.0);
                @define-color primary rgba(0, 0, 0, 0.75);

                window {
                    margin: 2px;
                    border: 2px solid;
                    border-color: #313244;
                    background-color: #1e1e2e;
                    border-radius: 10px;
                    font-family: monospace;
                    font-size: 14px;
                }

                #input {
                    padding: 2px;
                    margin: 4px;
                    margin-bottom: 8px;
                    border: none;
                    color: @foreground;
                    background-color: #313244;
        	    outline: none;
                }

                #inner-box {
                    margin: 2px;
                    border: 0px solid;
                    background-color: @clear;
                    border-radius: 8px;
                }

                #outer-box {
                    margin: 5px;
                    border: none;
                    border-radius: 8px;
                    background-color: @clear;
                }

                #scroll {
                    margin: 0px;
                    border: none;
                }

                #text:selected {
                    color: @foreground;
                    margin: 0px 0px;
                    border: none;
                    border-radius: 8px;
                }

                #entry {
                    margin: 0px 0px;
                    border: none;
                    border-radius: 0px;
                    background-color: transparent;
                }

                #entry:selected {
                    margin: 0px 0px;
                    border: none;
                    border-radius: 8px;
                    background-color: #585b70;
                }
      '';
    };
  };
}
