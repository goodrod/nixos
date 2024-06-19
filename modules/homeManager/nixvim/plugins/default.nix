{ config, pkgs, lib, ... }:

{
  imports = [ ./cmp.nix ];
  config = {
    programs.nixvim = {
      extraPlugins = with pkgs.vimPlugins; [
        {
          plugin = comment-nvim;
          config = ''lua require("Comment").setup()'';
        }
        gruvbox
      ];
      colorschemes.gruvbox.enable = true;
      plugins = {
        lightline.enable = true;
        bufferline.enable = true;
        telescope.enable = true;
        oil.enable = true;
        treesitter.enable = true;
        friendly-snippets.enable = true;
        harpoon = {
          enable = true;
          keymaps.addFile = "<leader>a";
        };
        luasnip = {
          enable = true;
          fromVscode = [ { } ];
        };
        lsp = {
          enable = true;
          servers = {
            tsserver.enable = true;
            lua-ls = {
              enable = true;
              settings.telemetry.enable = false;
            };
          };
        };
      };
    };
  };
}
