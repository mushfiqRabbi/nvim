return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "html",
        "javascriptreact",
        "typescriptreact",
      },
    })
    vim.keymap.set(
      "n",
      "<leader>tc",
      ":ColorizerToggle<CR>",
      { desc = "[T]oggle [C]olorizer", noremap = true, silent = true }
    )
  end,
}
