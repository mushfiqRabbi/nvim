return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {},
  config = function()
    require('hop').setup()
    local hop = require 'hop'
    vim.keymap.set('', ';', function()
      hop.hint_char1()
    end, { remap = true })
  end,
}
