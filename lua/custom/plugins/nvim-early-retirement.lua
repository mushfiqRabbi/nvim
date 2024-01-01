return {
  'chrisgrieser/nvim-early-retirement',
  -- config = true,
  event = 'VeryLazy',
  config = function()
    require('early-retirement').setup {
      retirementAgeMins = 15,
    }
  end,
}
