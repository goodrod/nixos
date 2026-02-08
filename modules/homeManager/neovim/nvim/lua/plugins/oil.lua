-- plugins/oil.lua

local M = {}

function M.setup()
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent dir in Oil" })

  require("oil").setup({
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    filter = function(name, _)
    -- show hidden except exclude '.' and '..'
    if name == "." or name == "../" then
      return false
    end
    return true
  end,
  })
end

return M

