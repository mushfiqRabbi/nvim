return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local parsers = {
      "css",
      "scss",
      "styled",
      "prisma",
    }
    for _, value in ipairs(parsers) do
      table.insert(opts.ensure_installed, value)
    end
  end,
}
