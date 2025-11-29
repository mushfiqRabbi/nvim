return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.remove(opts.sections.lualine_c)

    opts.options.component_separators = "│"
    opts.options.section_separators = ""

    opts.sections.lualine_a = {
      {
        "mode",
        color = { gui = "bold" },
      },
    }

    opts.sections.lualine_y = {
      { "location" },
    }

    opts.sections.lualine_z = {
      { "progress", color = { gui = "bold" } },
    }
  end,
}
