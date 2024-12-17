return {
  "ibhagwan/fzf-lua",
  -- BUG: use latest when fixed
  commit = "71de69c",
  dependencies = {
    "junegunn/fzf",
    build = "./install --bin",
  },
  keys = {
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search in Buffer" },
  },
  opts = function(_, opts)
    opts[1] = "borderless_full"
  end,
}
