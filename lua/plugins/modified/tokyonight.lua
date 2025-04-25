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
        fg = "#353b57", -- 10% shade
      }
      hl.MatchParen = {
        bold = true,
        fg = "#ff9e64",
        bg = "#545868", -- 20% tint
      }

      hl.SnacksPickerBorder = {
        fg = "#45475A",
        bg = "NONE",
      }

      hl.SnacksPickerTitle = {
        bg = "#7aa2f7",
        fg = "#1f2335",
      }

      hl.SnacksPickerPreview = {
        bg = "#1a1b26",
      }

      hl.SnacksPickerList = {
        bg = "#1a1b26",
      }

      hl.SnacksPickerListTitle = {
        bg = "#9ece6a",
        fg = "#1f2335",
      }

      hl.SnacksPickerInputTitle = {
        bg = "#f7768e",
        fg = "#1f2335",
      }

      hl.SnacksPickerInputBorder = {
        bg = "#1a1b26",
        fg = "#45475a",
      }

      hl.SnacksPickerInputSearch = {
        bg = "#f7768e",
        fg = "#1f2335",
      }

      hl.SnacksPickerInput = {
        bg = "#1a1b26",
      }

      hl.SnacksPickerToggleRegex = {
        bold = true,
        italic = true,
        fg = "#1f2335",
        bg = "#c65e72",
      }

      hl.SnacksPickerToggleHidden = {
        bold = true,
        italic = true,
        fg = "#1f2335",
        bg = "#c65e72",
      }

      hl.SnacksPickerToggleFollow = {
        bold = true,
        italic = true,
        fg = "#1f2335",
        bg = "#c65e72",
      }

      hl.SnacksPickerToggleIgnored = {
        bold = true,
        italic = true,
        fg = "#1f2335",
        bg = "#c65e72",
      }
      hl.SnacksPickerToggleModified = {
        bold = true,
        italic = true,
        fg = "#1f2335",
        bg = "#c65e72",
      }
    end,
  },
}
