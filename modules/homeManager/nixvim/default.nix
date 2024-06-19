{ config, pkgs, lib, ... }:

{
  imports = [ ./opts.nix ./keymaps ./plugins ];

  home.shellAliases.v = "nvim";
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
  };
}
