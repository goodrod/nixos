-- ~/.config/nvim/lua/modules/keymaps.lua
local M = {}

function M.setup()
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- Movement remaps (Swedish layout: jklö)
  map({ "n", "v" }, "j", "h", opts)
  map({ "n", "v" }, "k", "j", opts)
  map({ "n", "v" }, "l", "k", opts)
  map({ "n", "v" }, "ö", "l", opts)

  -- Optional: disable arrow keys entirely
  map("", "<Up>", "<Nop>", opts)
  map("", "<Down>", "<Nop>", opts)
  map("", "<Left>", "<Nop>", opts)
  map("", "<Right>", "<Nop>", opts)

  -- Escape using jk (normal/insert)
  map("i", "jk", "<Esc>", opts)
  map("i", "jj", "<Esc>", opts)

  -- Leader key
  vim.g.mapleader = " "
end

return M
