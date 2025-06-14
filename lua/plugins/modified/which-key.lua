return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>a", group = "ai", icon = { icon = "" } },
      { "<leader>d", group = "+dotfile/lazydocker", icon = { icon = "" } },
      { "<leader>dd", icon = { icon = "" } },
      { "<leader>di", icon = { icon = "" } },
      { "<leader>ds", icon = { icon = "󱀌" } },
      { "<leader>S", group = "+Search/Select", icon = { icon = "", color = "green" } },
      { "<leader>t", group = "+btop", icon = { icon = "" } },
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
      border = "solid",
    },
    show_help = false,
    show_keys = false,
  },
}
