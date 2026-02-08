local M = {}

M.setup = function()
  -- Enable true colors
  vim.o.termguicolors = true

  -- Statusline config (using lualine as example)
  require("lualine").setup {
    options = {
      theme = "gruvbox",  -- pick your fav theme
      section_separators = "",
      component_separators = "",
      globalstatus = true,
    },
  }

  -- Tabline (optional)
  vim.o.showtabline = 2

  -- Line numbers
  vim.wo.number = true
  vim.wo.relativenumber = true

  -- Cursor line
  vim.wo.cursorline = true

  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
  })

  -- Set colorscheme
  vim.cmd([[colorscheme gruvbox]])
end

return M

