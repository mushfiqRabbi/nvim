return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "hide", "fallback" },
      ["<C-e>"] = {},
      ["<A-e>"] = { "show_documentation", "hide_documentation", "fallback" },
    },
    completion = {
      documentation = {
        auto_show = true,
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
}
