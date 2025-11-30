return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        clear_suggestion = "<C-]>",
        accept_word = "<C-[>",
      },
    })
  end,
}
