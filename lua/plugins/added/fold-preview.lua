return {
  -- NOTE: FORKED
  "mushfiqRabbi/fold-preview.nvim",
  dependencies = {
    "anuvyklack/keymap-amend.nvim",
  },
  config = function()
    require("fold-preview").setup({})
  end,
}
