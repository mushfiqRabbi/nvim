return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "junegunn/fzf",
    build = "./install --all",
  },
  keys = {
    { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search in Buffer" },
  },
  opts = function(_, opts)
    local config = require("fzf-lua.config")

    opts[1] = "borderless_full"
    opts.fzf_opts["--no-scrollbar"] = false

    config.defaults.keymap.builtin["<c-f>"] = "preview-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-up"
    config.defaults.keymap.builtin["<c-p>"] = "toggle-preview"
    -- config.defaults.keymap.builtin["<c-h>"] = "toggle-help"
    config.defaults.keymap.builtin["<M-f>"] = "toggle-fullscreen"
    config.defaults.keymap.builtin["<M-w>"] = "toggle-preview-wrap"
    config.defaults.keymap.fzf["ctrl-z"] = "unix-line-discard"
  end,
}
