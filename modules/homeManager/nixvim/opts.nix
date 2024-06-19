{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      opts = {
        scrolloff = 999;
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };
    };
  };
}
