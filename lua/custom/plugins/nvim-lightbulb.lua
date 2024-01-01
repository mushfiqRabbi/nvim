return {
  "kosayoda/nvim-lightbulb",
  config = function()
    require("nvim-lightbulb").setup({
      hide_in_unfocused_buffer = false,
      number = {
        enabled = true,
      },
      autocmd = {
        enabled = true,
      },
    })

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        if vim.lsp.buf.server_ready() then
          local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
          if next(vim.diagnostic.get(0, { lnum = r - 1 })) ~= nil then
            vim.cmd("hi LightBulbNumber gui=bold,italic guifg=#fde154")
          else
            vim.cmd("hi LightBulbNumber gui=NONE guifg=#89b4fa")
          end
        end
      end,
    })
  end,
}
