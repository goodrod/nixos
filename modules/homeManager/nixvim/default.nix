{ config, pkgs, lib, inputs, ... }:

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

  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
	  gp-nvim = prev.vimUtils.buildVimPlugin {
	    name = "gp-nvim";
	    src = inputs.gp-nvim-plugin;
	  };
	};
      }
      )
    ];
  };
}
