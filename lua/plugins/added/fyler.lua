return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable", -- Use stable branch for production
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        local current_win = vim.api.nvim_get_current_win()
        local is_fyler_buffer = vim.api.nvim_buf_get_name(0):match("^fyler://") ~= nil

        require("fyler").toggle({ dir = LazyVim.root() })

        -- Only restore window if we weren't in fyler buffer before toggling
        if not is_fyler_buffer and vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_set_current_win(current_win)
        end
      end,
      desc = "Toggle Fyler (root dir)",
    },
    {
      "<leader>E",
      function()
        local current_win = vim.api.nvim_get_current_win()
        local is_fyler_buffer = vim.api.nvim_buf_get_name(0):match("^fyler://") ~= nil

        require("fyler").toggle({ dir = vim.uv.cwd() })

        -- Only restore window if we weren't in fyler buffer before toggling
        if not is_fyler_buffer and vim.api.nvim_win_is_valid(current_win) then
          vim.api.nvim_set_current_win(current_win)
        end
      end,
      desc = "Toggle Fyler (cwd)",
    },
  },
  opts = {
    views = {
      finder = {
        close_on_select = false,
        watcher = {
          enabled = true,
        },
        win = {
          kind = "split_left_most",
          kinds = {
            split_left_most = {
              width = "15%",
              win_opts = {
                winfixwidth = true,
              },
            },
          },
          win_opts = {
            cursorline = true,
          },
        },
      },
    },
  },
}
