return {
  "nvim-treesitter/nvim-treesitter",
  ---@diagnostic disable-next-line: unused-local
  opts = function(_, opts)
    local parsers = {
      "css",
      "scss",
      "styled",
      "tmux",
      "prisma",
    }
    for index, value in ipairs(parsers) do
      table.insert(opts.ensure_installed, value)
    end
  end,
}
