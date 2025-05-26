-- ~/.config/nvim/lua/modules/whichkey.lua
local M = {}

function M.setup()
  local wk = require("which-key")
  wk.setup({
    plugins = { spelling = true },
  })
  wk.add({
  })
end

return M
