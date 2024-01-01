return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    vim.g.codeium_disable_bindings = 1
    vim.keymap.set("i", "<C-g>", function()
      -- vim.keymap.set('i', '<tab>', function()
      return vim.fn["codeium#Accept"]()
    end, { noremap = true, expr = true })
    -- vim.keymap.set('i', '<c-;>', function()
    --   return vim.fn['codeium#CycleCompletions'](1)
    -- end, { expr = true })
    -- vim.keymap.set('i', '<c-,>', function()
    --   return vim.fn['codeium#CycleCompletions'](-1)
    -- end, { expr = true })
    -- vim.keymap.set('i', '<esc>', function()
    --   return vim.fn['codeium#Clear']()
    -- end, { expr = true })
  end,
}
