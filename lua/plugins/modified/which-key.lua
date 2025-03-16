return {
  "folke/which-key.nvim",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>c", group = "+code/ium" },
      { "<leader>ch", icon = { icon = "󰻞 " } },
      { "<leader>g", group = "+git/generate" },
      { "<leader>gd", group = "+dotfile", icon = { icon = "󰘓" } },
      { "<leader>gdi", icon = { icon = "" } },
      { "<leader>gds", icon = { icon = "󰓆" } },
      { "<leader>s", group = "+search/superfile" },
      { "<leader>sf", icon = { icon = "󰙅" } },
    },
    win = {
      no_overlap = false,
      border = "none",
    },
    show_help = false,
    show_keys = false,
  },
}
