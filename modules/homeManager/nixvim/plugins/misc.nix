{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      plugins = {
        lightline.enable = true;
        bufferline.enable = true;
        telescope.enable = true;
        web-devicons.enable = true;
        oil.enable = true;
        treesitter.enable = true;
        transparent.enable = true;
        undotree.enable = true;
        fugitive.enable = true;
      };
    };
  };
}
