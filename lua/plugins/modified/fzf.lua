return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "junegunn/fzf",
    build = "./install --bin",
  },
  keys = {
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search in Buffer" },
  },
  opts = function(_, opts)
    opts[1] = "borderless_full"
    opts.fzf_opts["--no-scrollbar"] = false
  end,
}
