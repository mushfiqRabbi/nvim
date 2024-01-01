return {
  'dnlhc/glance.nvim',
  config = function()
    local glance = require 'glance'
    local actions = glance.actions
    require('glance').setup {
      -- your configuration
      mappings = {
        list = {
          ['<leader>l'] = false,
          ['<leader>j'] = actions.enter_win 'preview',
        },
        preview = {
          ['<leader>l'] = false,
          ['<leader>j'] = actions.enter_win 'list',
        },
      },
      folds = {
        folded = false,
      },
    }
    vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
    vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
  end,
}
