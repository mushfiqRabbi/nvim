return {
  "saghen/blink.cmp",
  dependencies = {
    "xzbdmw/colorful-menu.nvim",
  },
  opts = {
    keymap = {
      preset = "enter",
    },

    completion = {
      menu = {
        draw = {
          components = {
            label = {
              ellipsis = true,
            },
            label_description = {
              ellipsis = true,
            },
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
      keymap = {
        preset = "inherit",
        ["<CR>"] = { "accept_and_enter", "fallback" },
      },
      completion = {
        list = {
          selection = {
            auto_insert = true,
          },
        },
        menu = {
          auto_show = true,
        },
        ghost_text = { enabled = true },
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
