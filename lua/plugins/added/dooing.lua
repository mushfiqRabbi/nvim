return {
  "atiladefreitas/dooing",
  event = "VeryLazy",
  config = function()
    require("dooing").setup({
      save_path = vim.fn.expand("~") .. "/dooing_todos.json",
      quick_keys = false, -- Quick keys window
      -- your custom config here (optional)
    })
  end,
}
