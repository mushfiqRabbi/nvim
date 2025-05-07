return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sr",
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
      desc = "Search and Replace in Current File",
    },
    {
      "<leader>sR",
      function()
        local grug = require("grug-far")
        -- local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        -- grug.open({
        --   transient = true,
        --   prefills = {
        --     filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        --   },
        -- })

        grug.open({
          transient = true,
          prefills = {
            paths = LazyVim.root(),
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
}
