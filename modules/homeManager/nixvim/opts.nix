{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      opts = {
        scrolloff = 20;
        number = true;
        relativenumber = true;
        statuscolumn = "%l %r";
        shiftwidth = 2;
      };
    };
  };
}
