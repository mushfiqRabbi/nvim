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
        local finder = require("fyler.views.finder")
        local is_open = finder._current ~= nil
          and finder._current.win
          and finder._current.win:has_valid_winid()

        if is_open then
          require("fyler").close()
        else
          -- Ensure clean state and open with smooth focus management
          require("fyler").close()
          vim.defer_fn(function()
            require("fyler").open({ dir = LazyVim.root() })

            -- Switch back to original window immediately to prevent focus steal
            vim.defer_fn(function()
              vim.api.nvim_set_current_win(old_win)

              -- Then navigate to current file after a delay
              vim.defer_fn(function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                if buf_name ~= "" then
                  require("fyler").navigate(buf_name)
                end
              end, 200)
            end, 10) -- Very short delay to switch focus back quickly
          end, 50)
        end
      end,
      desc = "Toggle Fyler (root dir)",
    },
    {
      "<leader>E",
      function()
        local old_win = vim.api.nvim_get_current_win()
        local finder = require("fyler.views.finder")
        local is_open = finder._current ~= nil
          and finder._current.win
          and finder._current.win:has_valid_winid()

        if is_open then
          require("fyler").close()
        else
          -- Ensure clean state and open with smooth focus management
          require("fyler").close()
          vim.defer_fn(function()
            require("fyler").open({ dir = vim.uv.cwd() })

            -- Switch back to original window immediately to prevent focus steal
            vim.defer_fn(function()
              vim.api.nvim_set_current_win(old_win)

              -- Then navigate to current file after a delay
              vim.defer_fn(function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                if buf_name ~= "" then
                  require("fyler").navigate(buf_name)
                end
              end, 200)
            end, 10) -- Very short delay to switch focus back quickly
          end, 50)
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
