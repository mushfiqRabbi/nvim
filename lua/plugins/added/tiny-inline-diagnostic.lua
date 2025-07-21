return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy", -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require("tiny-inline-diagnostic").setup({
      options = {
        show_source = {
          enabled = true,
        },
        multilines = {
          enabled = true,
          always_show = true,
        },
        overflow = {
          padding = 5,
        },
      },
    })
  end,
}
