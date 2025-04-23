return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    local servers = {
      "codespell",
      "cspell",
      "prettierd",
      "rustywind",
      "gitlint",
    }

    ---@diagnostic disable-next-line: unused-local
    for index, value in ipairs(servers) do
      table.insert(opts.ensure_installed, value)
    end
  end,
}
