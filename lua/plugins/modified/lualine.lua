return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.remove(opts.sections.lualine_c)
    local lint_progress = function()
      local linters = require("lint").get_running()
      if #linters == 0 then
        return "󰦕 "
      end
      return "󱉶 " .. table.concat(linters, ", ")
    end

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
    table.insert(opts.sections.lualine_x, { lint_progress })
    opts.sections.lualine_y = {
      { "progress" },
    }
    opts.sections.lualine_z = {
      { "location", color = { gui = "bold" } },
    }
  end,
}
