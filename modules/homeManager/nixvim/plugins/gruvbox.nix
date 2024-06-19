{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [ gruvbox ];
      colorschemes.gruvbox = {
        enable = true;
        settings.transparent_bg = true;
      };
    };
  };
}
