return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    -- List of language servers and tools to ensure are installed
    local servers = {
      "cspell", -- Spell checker
      "prettierd", -- JavaScript/TypeScript formatter
      "rustywind", -- Tailwind CSS class sorting
      "gitlint", -- Git commit message linter
    }

    -- Add these servers to the ensure_installed list
    for _, value in ipairs(servers) do
      table.insert(opts.ensure_installed, value)
    end
  end,
}
