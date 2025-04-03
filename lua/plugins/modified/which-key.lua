return {
  "folke/which-key.nvim",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>d", group = "+dotfile", icon = { icon = "" } },
      { "<leader>di", icon = { icon = "" } },
      { "<leader>ds", icon = { icon = "󱀌" } },
      -- { "<leader>c", group = "+code/ium" },
      -- { "<leader>ch", icon = { icon = "󰻞 " } },
      -- { "<leader>g", group = "+git/generate" },
      -- { "<leader>gd", group = "+dotfile", icon = { icon = "" } },
      -- { "<leader>gdi", icon = { icon = "" } },
      -- { "<leader>gds", icon = { icon = "󱀌" } },
      -- { "<leader>gdns", icon = { icon = "󱀌" } },
    },
    win = {
      no_overlap = false,
      border = "none",
    },
    show_help = false,
    show_keys = false,
  },
}
