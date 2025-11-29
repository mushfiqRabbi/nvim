return {
  "mfussenegger/nvim-lint",
  opts = function(_, opts)
    -- Remove fish linter
    for key, _ in pairs(opts.linters_by_ft) do
      if key == "fish" then
        opts.linters_by_ft[key] = nil
      end
    end

    -- Configure linters by file type
    local linters_by_ft = {
      sh = { "dotenv_linter" }, -- Shell files
      zsh = { "zsh" }, -- Zsh files
      gitcommit = { "gitlint" }, -- Git commit messages
      ["*"] = { "cspell" }, -- Spell check all files
    }

    -- Apply the linter configurations to the plugin options
    for key, value in pairs(linters_by_ft) do
      opts.linters_by_ft[key] = value
    end

    -- Define custom linters with conditions
    local linters = {
      cspell = {
        -- Conditional spell checking - skip for help files, .env files, and projects with .nocspell
        condition = function(ctx)
          local ignored_filetypes = { "help", "grug-far" }
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
        end,
      },
      dotenv_linter = {
        -- Only run on .env files
        condition = function(ctx)
          if not string.match(vim.fn.fnamemodify(ctx.filename, ":t"), "%.env.*") then
            return false
          end
          return true
        end,
      },
    }

    -- Apply the custom linter configurations to the plugin options
    for key, value in pairs(linters) do
      opts.linters[key] = value
    end
  end,
}
