-- ~/.config/nvim/lua/plugins/treesitter.lua
local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { },

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = {
      enable = true,
    },
  })
end

return M
