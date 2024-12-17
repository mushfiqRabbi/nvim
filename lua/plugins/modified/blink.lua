return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "hide", "fallback" },
      ["<C-e>"] = { "show_documentation", "hide_documentation", "fallback" },
    },
    completion = {
      ghost_text = {
        enabled = false,
      },
    },
  },
}
