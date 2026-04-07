---@module "fyler"
return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-mini/mini.icons" },
  -- branch = "stable",
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        require("fyler").toggle({ dir = LazyVim.root() })
      end,
      desc = "Open Fyler View",
    },
  },
  opts = {
    views = {
      finder = {
        close_on_select = false,
        icon = {
          directory_collapsed = "",
          directory_empty = "",
          directory_expanded = "",
        },
        mappings = {
          ["|"] = "SelectVSplit",
          ["-"] = "SelectSplit",
          ["^"] = "GotoParent",
          ["="] = "GotoCwd",
          ["."] = "GotoNode",
          ["#"] = "CollapseAll",
        },
        watcher = {
          enabled = true,
        },
        win = {
          kind = "split_left_most",
          kinds = {
            split_left_most = {
              width = "15%",
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
