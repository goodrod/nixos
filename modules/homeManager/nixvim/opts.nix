{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      clipboard = {
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };
    };
  };
}
