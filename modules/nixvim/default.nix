{ config, pkgs, lib, ... }:

{
  config = {
    programs.nixvim = {
      enable = true;
      extraPlugins = with pkgs.vimPlugins; [
        {
          plugin = comment-nvim;
          config = ''lua require("Comment").setup()'';
        }
        gruvbox
      ];

      colorschemes.gruvbox.enable = true;
      globals.mapleader = ",";

      keymaps = [
        {
          mode = "";
          key = "j";
          action = "h";
        }
        {
          mode = "";
          key = "k";
          action = "j";
        }
        {
          mode = "";
          key = "l";
          action = "k";
        }
        {
          mode = "";
          key = "ö";
          action = "l";
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>g";
        }
      ];

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };

      plugins = {
        lightline.enable = true;
        bufferline.enable = true;
        telescope.enable = true;
        oil.enable = true;
        treesitter.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-path.enable = true;
        cmp-buffer.enable = true;
        cmp_luasnip.enable = true;
        friendly-snippets.enable = true;

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

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "path"; }
              { name = "buffer"; }
            ];

            snippet = {
              expand =
                "function(args) require('luasnip').lsp_expand(args.body) end";
            };

            mapping = {
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = ''
                function(fallback)
		  local luasnip = require("luasnip")
		  local has_words_before = function()
                    unpack = unpack or table.unpack
                    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
                  end
                  if cmp.visible() then
                    if #cmp.get_entries() == 1 then
                      cmp.confirm({ select = true })
                    else
                      cmp.select_next_item()
                    end
                  elseif luasnip.expandable() then
                    luasnip.expand()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif has_words_before() then
                    cmp.complete()
                    if #cmp.get_entries() == 1 then
                      cmp.confirm({ select = true })
                    end
                  else
                    fallback()
                  end
                end
              '';
            };
          };
        };

      };

      highlight = {
        Comment.fg = "#ff00ff";
        Comment.bg = "#000000";
        Comment.underline = true;
        Comment.bold = true;
      };
    };
  };
}
