return {
  "gen740/SmoothCursor.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("smoothcursor").setup({
      ---@diagnostic disable-next-line: missing-fields
      fancy = {
        ---@diagnostic disable-next-line: missing-fields
        enable = true,
        ---@diagnostic disable-next-line: assign-type-mismatch
        head = false,
      },
      priority = 100,
      disable_float_win = true,
      disabled_filetypes = {
        -- "help",
        "alpha",
        "starter",
        "dashboard",
        "neo-tree",
        "neo-tree-popup",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "lspinfo",
        -- "checkhealth",
        "noice",
      },
    })
  end,
}
