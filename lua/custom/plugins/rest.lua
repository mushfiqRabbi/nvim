-- plugins/rest.lua
return {
  'rest-nvim/rest.nvim',
  commit = '8b62563',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    require('rest-nvim').setup {
      --- Get the same options from Packer setup
      skip_ssl_verification = true,
    }
    vim.keymap.set('n', '<leader>rr', '<Plug>RestNvim', { noremap = true, silent = true, desc = '[R]est [R]equest' })
  end,
}
