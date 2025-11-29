return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>a", group = "+ai", icon = { icon = "" } },

      { "<leader>d", group = "+diff", icon = { icon = "" } },
      { "<leader>df", icon = { icon = "" } },
      { "<leader>dF", icon = { icon = "󰳏" } },

      { "<leader>r", group = "Search and Replace", icon = { icon = "󰛔" } },

      { "<leader>t", group = "+todo", icon = { icon = "" } },
    },
    win = {
      no_overlap = false,
      border = "solid",
    },
    show_help = false,
  },
}
