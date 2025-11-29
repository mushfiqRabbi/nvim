return {
  "folke/tokyonight.nvim",
  opts = {
    style = "moon",
    on_highlights = function(hl, _)
      -- NOTE shade and tint from https://noeldelgado.github.io/shadowlord/#3b4261
      hl.IndentDark = {
        fg = "#323852",
      }
      hl.IndentLight = {
        fg = "#585e79",
      }
      hl.MatchParen = {
        bold = true,
        fg = "#ffc777",
        bg = "#545c7e",
      }
      hl.DiagnosticUnnecessary = {
        fg = "#696e8f",
      }
      hl.FylerIndentMarker = {
        default = true,
        fg = "#444a62",
      }
    end,
  },
}
