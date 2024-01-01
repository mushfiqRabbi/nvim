return {
  "svban/YankAssassin.vim",
  config = function()
    vim.cmd([[
      nmap <leader>y <Plug>YADefault
      xmap <leader>y <Plug>YADefault
    ]])
  end,
}
