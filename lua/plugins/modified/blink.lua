return {
  "saghen/blink.cmp",
  dependencies = {
    "xzbdmw/colorful-menu.nvim",
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<C-space>"] = { "show", "hide", "fallback" },
      ["<C-e>"] = {},
      ["<A-e>"] = { "show_documentation", "hide_documentation", "fallback" },
    },
    completion = {
      -- menu = {
      --   draw = {
      --     -- We don't need label_description now because label and label_description are already
      --     -- combined together in label by colorful-menu.nvim.
      --     columns = { { "kind_icon" }, { "label", gap = 1 } },
      --     components = {
      --       label = {
      --         -- width = { fill = true, max = 60 },
      --         text = function(ctx)
      --           local highlights_info = require("colorful-menu").blink_highlights(ctx)
      --           if highlights_info ~= nil then
      --             -- Or you want to add more item to label
      --             return highlights_info.label
      --           else
      --             return ctx.label
      --           end
      --         end,
      --         highlight = function(ctx)
      --           local highlights = {}
      --           local highlights_info = require("colorful-menu").blink_highlights(ctx)
      --           if highlights_info ~= nil then
      --             highlights = highlights_info.highlights
      --           end
      --           for _, idx in ipairs(ctx.label_matched_indices) do
      --             table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
      --           end
      --           -- Do something else
      --           return highlights
      --         end,
      --       },
      --     },
      --   },
      -- },
      -- documentation = {
      --   auto_show = true,
      -- },
      ghost_text = {
        enabled = false,
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
