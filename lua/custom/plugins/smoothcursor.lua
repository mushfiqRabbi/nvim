return {
  'gen740/SmoothCursor.nvim',
  config = function()
    require('smoothcursor').setup {
      priority = 1,
      fancy = {
        enable = true,
      },
      disable_float_win = true, -- Disable in floating windows
    }
    local autocmd = vim.api.nvim_create_autocmd

    autocmd({ 'ModeChanged' }, {
      callback = function()
        local current_mode = vim.fn.mode()
        if current_mode == 'n' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#89b4fa' })
        elseif current_mode == 'v' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#cba6f7' })
        elseif current_mode == 'V' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#cba6f7' })
        elseif current_mode == '\22' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#cba6f7' })
        elseif current_mode == 'i' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#a6e3a1' })
        elseif current_mode == 'R' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#f38ba8' })
        elseif current_mode == 'c' then
          vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#fab387' })
        end
      end,
    })
  end,
}
