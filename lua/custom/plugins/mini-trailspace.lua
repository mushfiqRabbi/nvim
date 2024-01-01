return {
  'echasnovski/mini.trailspace',
  version = '*',
  config = function()
    require('mini.trailspace').setup()
    -- vim.keymap.set({ 'n', 'v' }, '<leader>ts', ':lua MiniTrailspace.trim()<CR>', { noremap = true, silent = true, desc = '[T]rim [S]paces' })
    -- vim.keymap.set({ 'n', 'v' }, '<leader>tl', ':lua MiniTrailspace.trim_last_lines()<CR>', { noremap = true, silent = true, desc = '[T]rim [L]ines' })

    vim.api.nvim_set_hl(0, 'MiniTrailspace', { bg = '#ed8796' })
  end,
}
