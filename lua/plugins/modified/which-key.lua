return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>b", group = "+buffer/btop" },
      { "<leader>d", group = "+dotfile", icon = { icon = "" } },
      { "<leader>ld", icon = { icon = "" } },
      { "<leader>lg", icon = { icon = "" } },
      { "<leader>li", icon = { icon = "" } },
      { "<leader>ll", icon = { icon = "󰒲" } },
      { "<leader>lr", icon = { icon = "󰜉" } },
      { "<leader>di", icon = { icon = "" } },
      { "<leader>ds", icon = { icon = "󱀌" } },
      { "<leader>l", group = "+lazy", icon = { icon = "󰒲" } },
      { "<leader>M", icon = { icon = "" } },
      { "<leader>s", group = "+search/replace" },
      { "<leader>t", group = "+todo", icon = { icon = "" } },
      { "<leader>tT", icon = { icon = "" } },
    },
    win = {
      no_overlap = false,
      border = "solid",
    },
    show_help = false,
    show_keys = false,
  },
}
