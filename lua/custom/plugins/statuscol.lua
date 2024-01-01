return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({

      ft_ignore = { "NvimTree" },

      segments = {
        {
          text = { "%s" },
          click = "v:lua.ScSa",
        },
        {
          text = { builtin.lnumfunc, " " },
          click = "v:lua.ScLa",
        },
        {
          text = { builtin.foldfunc, "  " },
          click = "v:lua.ScFa",
        },
      },
    })
  end,
}
