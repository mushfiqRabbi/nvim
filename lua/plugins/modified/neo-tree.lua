return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "stevearc/oil.nvim",
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      bind_to_cwd = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
    },
    window = {
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        ["O"] = {
          function(state)
            local node = state.tree:get_node()
            local target_item = nil
            local parent_path = nil

            if node.type == "directory" then
              target_item = vim.fn.fnamemodify(node.path, ":t") -- Get just the directory name
              parent_path = vim.fn.fnamemodify(node.path, ":h") -- Get parent directory
              require("oil").open_float(parent_path)
            elseif node.type == "file" then
              target_item = vim.fn.fnamemodify(node.path, ":t") -- Get just the filename
              require("oil").open_float(node._parent_id)
            else
              vim.print("Not a file or directory")
              return
            end

            -- Wait a bit for the floating window to open
            vim.defer_fn(function()
              -- Get all windows
              local wins = vim.api.nvim_list_wins()

              -- Find the floating window (oil buffer)
              for _, win in ipairs(wins) do
                local config = vim.api.nvim_win_get_config(win)
                if config.relative ~= "" then -- This is a floating window
                  local buf = vim.api.nvim_win_get_buf(win)
                  local buf_name = vim.api.nvim_buf_get_name(buf)

                  -- Check if it's an oil buffer
                  if buf_name:match("oil://") then
                    -- Move cursor to the target item (file or directory)
                    if target_item then
                      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                      for i, line in ipairs(lines) do
                        -- Oil shows items without leading path, so match the item name
                        if line:match(vim.pesc(target_item)) then
                          vim.api.nvim_win_set_cursor(win, { i, 0 })
                          break
                        end
                      end
                    end
                    break
                  end
                end
              end
            end, 100) -- 100ms delay
          end,
          desc = "Open in float oil window and move cursor to item",
        },
      },
    },
    event_handlers = {
      {
        event = "file_added",
        handler = function(path)
          require("neo-tree.command").execute({
            reveal_file = path,
          })
        end,
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ action = "show", toggle = true, dir = LazyVim.root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ action = "show", toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  },
}
