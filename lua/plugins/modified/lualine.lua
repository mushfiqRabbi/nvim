return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- dont show the winbar for some filetypes
    -- opts.options.disabled_filetypes.winbar = { "dashboard", "lazy", "alpha" }
    -- remove navic from the statusline
    -- local navic = table.remove(opts.sections.lualine_c)
    -- add it to the winbar instead
    -- opts.winbar = { lualine_b = { "filename" }, lualine_c = { navic } }

    -- remove the component C
    table.remove(opts.sections.lualine_c)

    opts.options.component_separators = "│"
    opts.options.section_separators = ""

    opts.sections.lualine_a = {
      {
        "mode",
        color = { gui = "bold" },
        -- icon_enabled = true,
        -- icon = "",
      },
    }

    -- local lint_progress = function()
    --   local linters = require("lint").get_running()
    --   if #linters == 0 then
    --     return "󰦕 "
    --   end
    --   return "󱉶 " .. table.concat(linters, ", ")
    -- end
    -- table.insert(opts.sections.lualine_x, { lint_progress })
    --
    opts.sections.lualine_y = {
      { "location" },
    }

    -- opts.sections.lualine_y = {
    --   {
    --     "lsp_status",
    --     icon = " ",
    --     symbols = {
    --       spinner = {
    --         "⢄",
    --         "⢂",
    --         "⢁",
    --         "⡁",
    --         "⡈",
    --         "⡐",
    --         "⡠",
    --       },
    --       -- done = " ",
    --     },
    --   },
    -- }

    opts.sections.lualine_z = {
      { "progress", color = { gui = "bold" } },
    }
  end,
}
