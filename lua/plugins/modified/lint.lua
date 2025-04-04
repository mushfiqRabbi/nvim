return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    -- @diagnostic disable-next-line: duplicate-set-field
    -- local function removekey(table, key)
    -- local element = table[key]
    -- table[key] = nil
    -- return element
    -- end

    for key, _ in pairs(opts.linters_by_ft) do
      if key == "fish" then
        opts.linters_by_ft[key] = nil
        -- removekey(opts.linters_by_ft, key)
      end
    end

    local linters_by_ft = {
      sh = { "dotenv_linter" },
      zsh = { "zsh" },
      ["*"] = { "cspell" },
      -- ["*"] = { "cspell", "codespell" },
    }

    for key, value in pairs(linters_by_ft) do
      opts.linters_by_ft[key] = value
    end

    local linters = {
      cspell = {
        condition = function(ctx)
          -- local buf = vim.api.nvim_get_current_buf()
          -- local filetype = vim.bo[buf].filetype
          local ignored_filetypes = {
            "help",
          }
          local filetype = vim.bo.filetype
          if vim.tbl_contains(ignored_filetypes, filetype) then
            return false
          end

          if string.match(vim.fn.fnamemodify(ctx.filename, ":t"), "%.env.*") then
            return false
          end

          local nocspell_stat = vim.uv.fs_stat(LazyVim.root() .. "/.nocspell")
          if nocspell_stat and nocspell_stat.type == "file" then
            return false
          end

          return true
          -- return ctx.filename ~= ""
          -- and not vim.fs.find({ ".nocspell" }, { path = ctx.dirname, type = "file", upward = true })[1]
        end,
      },
      -- codespell = {
      --   condition = function(ctx)
      --     return ctx.filename ~= ""
      --       and vim.fs.find({ ".codespell" }, { path = ctx.dirname, type = "file", upward = true })[1]
      --   end,
      -- },
      dotenv_linter = {
        condition = function(ctx)
          if not string.match(vim.fn.fnamemodify(ctx.filename, ":t"), "%.env.*") then
            return false
          end

          return true
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
