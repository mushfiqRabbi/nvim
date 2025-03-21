return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    ---@diagnostic disable-next-line: duplicate-set-field
    function table.removekey(table, key)
      local element = table[key]
      table[key] = nil
      return element
    end

    ---@diagnostic disable-next-line: unused-local
    for key, value in pairs(opts.linters_by_ft) do
      if key == "fish" then
        table.removekey(opts.linters_by_ft, key)
      end
    end

    local linters_by_ft = {
      sh = { "dotenv_linter" },
      zsh = { "zsh" },
      -- ["*"] = { "cspell", "codespell" },
    }

    for key, value in pairs(linters_by_ft) do
      opts.linters_by_ft[key] = value
    end

    local linters = {
      -- cspell = {
      --   condition = function(ctx)
      --     return ctx.filename ~= ""
      --       and vim.fs.find({ ".cspell" }, { path = ctx.dirname, type = "file", upward = true })[1]
      --   end,
      -- },
      -- codespell = {
      --   condition = function(ctx)
      --     return ctx.filename ~= ""
      --       and vim.fs.find({ ".codespell" }, { path = ctx.dirname, type = "file", upward = true })[1]
      --   end,
      -- },
      dotenv_linter = {
        condition = function(ctx)
          if string.match(vim.fn.fnamemodify(ctx.filename, ":t"), "%.env.*") then
            return true
          end
          -- local dotenv_file_names = { ".env", ".env.local" }
          --
          -- local function is_dotenv(filename)
          --   for _, dotenv_file_name in ipairs(dotenv_file_names) do
          --     if filename == dotenv_file_name then
          --       return true
          --     end
          --   end
          --   return false
          -- end
          --
          -- return is_dotenv(vim.fn.fnamemodify(ctx.filename, ":t"))
        end,
      },
    }

    for key, value in pairs(linters) do
      opts.linters[key] = value
    end
  end,
}
