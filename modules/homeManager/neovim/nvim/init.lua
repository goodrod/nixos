-- ~/.config/nvim/init.lua
local config_dir = vim.fn.stdpath("config")

local function is_lua_file(name)
  return name:match("%.lua$")
end

local function is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

local function try_setup_module(mod)
  local ok, loaded = pcall(require, mod)
  if not ok then
    vim.notify("Failed to require module: " .. mod .. "\n" .. loaded, vim.log.levels.ERROR)
    return
  end

  if type(loaded) == "table" and type(loaded.setup) == "function" then
    local success, err = pcall(loaded.setup)
    if not success then
      vim.notify("Error in setup() of module: " .. mod .. "\n" .. err, vim.log.levels.ERROR)
    end
  end
end

local function load_modules_from(dir, prefix)
  local scan = vim.loop.fs_scandir(dir)
  if not scan then return end

  while true do
    local name = vim.loop.fs_scandir_next(scan)
    if not name then break end

    local full_path = dir .. "/" .. name
    if is_lua_file(name) then
      local mod = prefix .. name:sub(1, -5)
      try_setup_module(mod)
    elseif is_directory(full_path) then
      load_modules_from(full_path, prefix .. name .. ".")
    end
  end
end

vim.opt.relativenumber = true
vim.opt.number = true
load_modules_from(config_dir .. "/lua/plugins", "plugins.")

