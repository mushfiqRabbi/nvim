return {
  "folke/tokyonight.nvim",
  opts = {
    style = "moon",
    ---@diagnostic disable-next-line: unused-local
    on_highlights = function(hl, c)
      -- NOTE: shade and tint from https://noeldelgado.github.io/shadowlord/#3b4261
      hl.IndentDark = {
        fg = "#323852",
      }
      hl.IndentLight = {
        fg = "#585e79",
      }
      hl.MatchParen = {
        bold = true,
        fg = "#ffc777",
        bg = "#636da6",
      }
    end,
  },
}
