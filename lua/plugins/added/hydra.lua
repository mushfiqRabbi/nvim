return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  config = function()
    local WindowHydra = require("hydra")
    WindowHydra({
      name = "Window Management",
      config = {
        timeout = 500,
        hint = false,
      },
      mode = "n",
      body = "<c-w>",
      heads = {
        { "+", "<c-w>+", { desc = "Increase window height" } },
        { "-", "<c-w>-", { desc = "Decrease window height" } },
        { "<", "<c-w><", { desc = "Decrease window width" } },
        { ">", "<c-w>>", { desc = "Increase window width" } },
      },
    })
    local MotionHydra = require("hydra")
    MotionHydra({
      name = "Motion Management",
      config = {
        timeout = 500,
        hint = false,
      },
      mode = "n",
      body = "g",
      heads = {
        -- { "e", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Previous end of word" } },
        {
          "e",
          function()
            require("spider").motion("ge")
          end,
          { desc = "Previous end of word" },
        },
      },
    })
  end,
}
