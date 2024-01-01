return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.cmd([[
      let g:mkdp_auto_close = 0
    ]])

    vim.keymap.set("n", "<leader>MP", ":MarkdownPreviewToggle<CR>", { desc = "Toggle [M]arkdown [P]review" })
  end,
}
