return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable", -- Use stable branch for production
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        local old_win = vim.api.nvim_get_current_win()
        local was_open = require("fyler.views.finder")._current ~= nil
        require("fyler").toggle({ dir = LazyVim.root() })
        -- If fyler was just opened (wasn't open before), navigate to current file and switch back to original window
        local finder = require("fyler.views.finder")
        if
          not was_open
          and finder._current
          and finder._current.win
          and finder._current.win:has_valid_winid()
        then
          -- Navigate to current file after a short delay to ensure fyler is fully loaded
          vim.defer_fn(function()
            require("fyler").navigate(vim.api.nvim_buf_get_name(0))
          end, 100)
          vim.api.nvim_set_current_win(old_win)
        end
      end,
      desc = "Toggle Fyler (root dir)",
    },
    {
      "<leader>E",
      function()
        local old_win = vim.api.nvim_get_current_win()
        local was_open = require("fyler.views.finder")._current ~= nil
        require("fyler").toggle({ dir = vim.uv.cwd() })
        -- If fyler was just opened (wasn't open before), navigate to current file and switch back to original window
        local finder = require("fyler.views.finder")
        if
          not was_open
          and finder._current
          and finder._current.win
          and finder._current.win:has_valid_winid()
        then
          -- Navigate to current file after a short delay to ensure fyler is fully loaded
          vim.defer_fn(function()
            require("fyler").navigate(vim.api.nvim_buf_get_name(0))
          end, 100)
          vim.api.nvim_set_current_win(old_win)
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
