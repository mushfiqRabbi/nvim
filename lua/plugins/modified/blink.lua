return {
  "saghen/blink.cmp",
  dependencies = {
    "xzbdmw/colorful-menu.nvim",
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "hide", "fallback" },
      -- ["<C-e>"] = {},
      ["<A-e>"] = { "show_documentation", "hide_documentation", "fallback" },
    },
    completion = {
      list = {
        max_items = 7,
      },
      menu = {
        draw = {
          gap = 2,
          columns = {
            { "label", "label_description", gap = 2 },
            { "kind_icon", "kind" },
          },
        },
      },
      documentation = {
        auto_show = false,
      },
      ghost_text = {
        enabled = false,
      },
    },

    cmdline = {
      enabled = true,
      keymap = { preset = "inherit" },
      completion = {
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { "label" },
            },
          },
        },
      },
    },

    fuzzy = {
      sorts = {
        function(a, b)
          if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
            return
          end
          return b.client_name == "emmet_language_server"
        end,
        -- default sorts
        "score",
        "sort_text",
      },
    },
  },
}
