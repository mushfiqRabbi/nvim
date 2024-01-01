return {
  "dstein64/nvim-scrollview",
  config = function()
    require("scrollview").setup({
      scrollview_always_show = true,
      scrollview_excluded_filetypes = { "alpha" },
      scrollview_column = 4,
      scrollview_winblend = 0,
    })
  end,
}
