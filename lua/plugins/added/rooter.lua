return {
  "airblade/vim-rooter",
  event = "VeryLazy",
  config = function()
    vim.cmd([[
      let g:rooter_buftypes = ['']
      let g:rooter_patterns += ['.root']
    ]])
    vim.g.rooter_silent_chdir = 1
  end,
}
