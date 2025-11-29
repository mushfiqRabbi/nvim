return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sr",
      false,
    },
    {
      "<leader>rf",
      function()
        local grug = require("grug-far")
        grug.open({
          transient = true,
          prefills = {
            paths = vim.fn.expand("%"),
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace (Current File)",
    },
    {
      "<leader>rF",
      function()
        local grug = require("grug-far")

        grug.open({
          transient = true,
          prefills = {
            paths = LazyVim.root(),
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace (Root)",
    },
  },
  opts = {
    showCompactInputs = true,
  },
}
