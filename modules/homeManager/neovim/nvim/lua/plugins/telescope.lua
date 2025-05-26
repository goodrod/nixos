-- ~/.config/nvim/lua/plugins/telescope.lua
local M = {}

function M.setup()
  local actions = require("telescope.actions")
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-c>"] = actions.close,
        },
        n = {
          ["q"] = actions.close,
        },
      },
    },
  })

  local wk = require("which-key")
local wk = require("which-key")

  wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files", mode = "n" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files", mode = "n" },

    { "<leader>g", group = "Git" },
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files", mode = "n" },
  })
end

return M

