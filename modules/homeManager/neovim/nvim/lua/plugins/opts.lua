-- ~/.config/nvim/lua/plugins/visuals.lua
local M = {}

function M.setup()
  -------------------------------------- vim.o.tions ------------------------------------------
  vim.o.laststatus = 3
  vim.o.showmode = false

  vim.o.clipboard = "unnamedplus"
  vim.o.cursorline = true
  vim.o.cursorlineopt = "number"

  -- Indenting
  vim.o.expandtab = true
  vim.o.shiftwidth = 2
  vim.o.smartindent = true
  vim.o.tabstop = 2
  vim.o.softtabstop = 2

  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.mouse = "a"

  -- Numbers
  vim.o.number = true
  vim.o.numberwidth = 2
  vim.o.ruler = false

  -- disable nvim intro
  vim.o.signcolumn = "yes"
  vim.o.splitbelow = true
  vim.o.splitright = true
  vim.o.timeoutlen = 400
  vim.o.undofile = true
  vim.opt.cursorline = true        -- highlight current line
  vim.opt.termguicolors = true     -- better colors
  vim.opt.scrolloff = 5            -- buffer around cursor
  vim.opt.sidescrolloff = 5
  vim.opt.showmode = false         -- no -- INSERT -- in cmdline
  vim.o.expandtab = true
  vim.o.shiftwidth = 2
  vim.o.smartindent = true
  vim.o.tabstop = 2
  vim.o.softtabstop = 2

  vim.o.ignorecase = true
  vim.o.smartcase = true
  vim.o.mouse = "a"
  vim.opt.shortmess:append "sI"
  vim.opt.fillchars = { eob = " " }
end

return M

