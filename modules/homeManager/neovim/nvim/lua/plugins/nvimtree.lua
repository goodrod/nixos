-- ~/.config/nvim/lua/plugins/neotree.lua

local M = {}

function M.setup()
  local function open_on_click(state, line)
    local node = state.tree:get_node(line)
    if node and node.type == "file" then
      -- Move cursor to clicked node
      state.tree:set_cursor(line)
      -- Open file
      require("neo-tree.sources.manager").open_file(state, node)
    end
  end
  require("neo-tree").setup(
    {
      default_component_configs = {
        -- remove or disable the "readonly" or "status" component
        readonly = function() return "" end,  -- empty string disables status display
      },
      filters = { dotfiles = false },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        preserve_window_proportions = true,
      },
      filesystem = {
        follow_current_file = { enabled = true, },
        hijack_netrw_behavior = "disabled", -- don't auto-open
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false, -- hide dotfiles etc
          hide_dotfiles = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = { unmerged = "" },
          },
        },
      },
    }
  )
  vim.keymap.set("n", "<leader>e", ":Neotree toggle filesystem<CR>")
end

return M
