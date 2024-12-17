return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    ---@diagnostic disable-next-line: duplicate-set-field
    function table.removekey(table, key)
      local element = table[key]
      table[key] = nil
      return element
    end

    ---@diagnostic disable-next-line: unused-local
    for key, value in pairs(opts.formatters_by_ft) do
      if key == "fish" then
        table.removekey(opts.formatters_by_ft, key)
      end
    end

    local formatters_by_ft = {
      html = { "rustywind" },
      javascriptreact = { "rustywind" },
      typescriptreact = { "rustywind" },
      zsh = { "shfmt" },
      javascript = { "rustywind" },
      typescript = { "rustywind" },
      ["_"] = { "trim_whitespace" },
    }

    for key, value in pairs(formatters_by_ft) do
      if not opts.formatters_by_ft[key] then
        opts.formatters_by_ft[key] = value
      else
        for _, formatter in ipairs(value) do
          table.insert(opts.formatters_by_ft[key], formatter)
        end
      end
    end

    ---@param bufnr integer
    ---@param ... string
    ---@return string
    local function first(bufnr, ...)
      local conform = require("conform")
      for i = 1, select("#", ...) do
        local formatter = select(i, ...)
        if conform.get_formatter_info(formatter, bufnr).available then
          return formatter
        end
      end
      return select(1, ...)
    end

    local function value_exists(tbl, val)
      for _, v in ipairs(tbl) do
        if v == val then
          return true
        end
      end
      return false
    end

    local function filter(tbl, condition)
      local result = {}
      for _, v in ipairs(tbl) do
        if condition(v) then
          table.insert(result, v)
        end
      end
      return result
    end

    for key, value in pairs(opts.formatters_by_ft) do
      if value_exists(value, "prettier") then
        local filtered_table
        if #value > 1 then
          filtered_table = filter(value, function(x)
            return x ~= "prettier"
          end)
        end
        opts.formatters_by_ft[key] = function(bufnr)
          if filtered_table then
            return { first(bufnr, "prettierd", "prettier"), unpack(filtered_table) }
          else
            return { first(bufnr, "prettierd", "prettier") }
          end
        end
      end
    end
  end,
}
