return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  branch = "stable", -- Use stable branch for production
  keys = {
    {
      "<leader>fe",
      function()
        require("fyler").toggle({ dir = LazyVim.root() })
      end,
      desc = "Toggle Fyler (root dir)",
    },
  },

  opts = {
    views = {
      finder = {
        close_on_select = true,
        watcher = {
          enabled = false,
        },
        win = {
          kind = "float",
          kinds = {
            float = {
              height = "80%",
              width = "45%",
              top = "7%",
              left = "27%",
            },
          },
          win_opts = {
            cursorline = true,
            signcolumn = "yes",
          },
        },
      },
    },
  },
}
