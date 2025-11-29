return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("barbecue").setup({
      create_autocmd = false,
    })
    vim.api.nvim_create_autocmd({
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
