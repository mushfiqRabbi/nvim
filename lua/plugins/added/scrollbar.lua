return {
  "petertriho/nvim-scrollbar",
  enabled = false,
  event = "VeryLazy",
  config = function()
    require("scrollbar").setup({
      handlers = {
        cursor = false,
        gitsigns = false,
        search = false,
        ale = false,
      },
    })
  end,
}
