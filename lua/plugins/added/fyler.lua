return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable", -- Use stable branch for production
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        require("fyler").toggle({ dir = LazyVim.root() })
      end,
      desc = "Toggle Fyler (root dir)",
    },
    {
      "<leader>E",
      function()
        require("fyler").toggle({ dir = vim.uv.cwd() })
      end,
      desc = "Toggle Fyler (cwd)",
    },
  },
  opts = {
    views = {
      finder = {
        close_on_select = false,
        watcher = {
          enabled = false,
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
