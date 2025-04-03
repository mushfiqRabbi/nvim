return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    ---@diagnostic disable-next-line: unused-local
    on_highlights = function(hl, c)
      -- NOTE: shade and tint from https://maketintsandshades.com/#3b4261
      hl.IndentDark = {
        fg = "#292e44", -- 30% shade
      }
      hl.IndentLight = {
        fg = "#4f5571", -- 10% tint
      }
      hl.MatchParen = {
        bg = "#545868", -- 20% tint
      }
    end,
  },
}
