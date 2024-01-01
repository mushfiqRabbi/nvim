return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          on_open = function(win)
            vim.api.nvim_win_set_config(win, {
              focusable = false,
              zindex = 100,
              border = "single",
            })
          end,
        })
      end,
    },
  },
  event = "VeryLazy",
  config = function()
    require("noice").setup({
      popupmenu = {
        backend = "cmp",
      },
      lsp = {
        progress = {
          enabled = false,
        },
        signature = {
          auto_open = {
            enabled = false,
            trigger = false,
          },
          -- opts = {
          --   size = {
          --     max_height = math.floor((vim.o.lines * 0.45) + 0.5),
          --     max_width = math.floor((vim.o.columns * 0.6) + 0.5),
          --   },
          --   position = { row = 2, col = 0 },
          -- },
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        -- lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      views = {
        popup = {
          border = {
            style = "single",
          },
        },
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "single",
          },
        },
        confirm = {
          border = {
            style = "single",
          },
        },
        hover = {
          zindex = 100,
          border = {
            style = "single",
          },
        },
        popupmenu = {
          border = {
            style = "single",
          },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "%d fewer lines" },
              { find = "%d more lines" },
              { find = "-- .terminal. --" },
              { find = "-- VISUAL LINE --" },
              { find = "-- INSERT --" },
            },
          },
          opts = { skip = true },
        },
      },
    })
    vim.cmd("hi NoiceCmdlinePopupBorder guifg=#89b4fa")
  end,
}
