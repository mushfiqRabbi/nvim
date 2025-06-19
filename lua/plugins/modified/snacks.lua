return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files({
          hidden = true,
          ignored = true,
        })
      end,
      desc = "Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
      -- false,
    },
    {
      "<leader>e",
      false,
    },
    {
      "<leader>E",
      false,
    },
    {
      "<leader>fe",
      false,
    },
    {
      "<leader>fE",
      false,
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects({
          dev = {
            "~/",
            "~/.config",
            "~/net/build",
            "~/net/test",
            "~/garage/build",
            "~/garage/test",
          },
          patterns = {
            ".git",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "package.json",
            "Makefile",
            ".root",
          },
        })
      end,
      desc = "Projects",
    },
    {
      "<leader>S",
      false,
    },
    {
      "<leader>sR",
      function()
        local grug = require("grug-far")
        -- local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        -- grug.open({
        --   transient = true,
        --   prefills = {
        --     filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        --   },
        -- })

        grug.open({
          transient = true,
          prefills = {
            paths = LazyVim.root(),
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },

    {
      "<leader>Ss",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },

    {
      "<leader>Sr",
      function()
        Snacks.picker.resume()
      end,
      desc = "Search Resume",
    },
  },
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
       ████ ██████           █████      ██                     
      ███████████             █████                             
      █████████ ███████████████████ ███   ███████████   
     █████████  ███    █████████████ █████ ██████████████   
    █████████ ██████████ █████████ █████ █████ ████ █████   
  ███████████ ███    ███ █████████ █████ █████ ████ █████  
 ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],

        keys = {
          { icon = " ", key = "p", desc = "Projects", action = "<leader>fp" },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    explorer = {
      enabled = false,
    },
    indent = {
      indent = {
        char = "▏",
        hl = "IndentDark",
      },
      scope = {
        char = "▏",
        hl = "IndentLight",
      },
      chunk = {
        enabled = true,
        hl = "IndentLight",
        -- char = {
        -- corner_top = "┌",
        -- corner_bottom = "└",
        -- corner_top = "╭",
        -- corner_bottom = "╰",
        -- horizontal = "─",
        -- vertical = "│",
        -- arrow = ">",
        -- },
      },
    },
    -- lazygit = {
    --   config = {
    --     git = {
    --       paging = {
    --         -- colorArg = "always",
    --         pager = table.concat({
    --           "delta",
    --           "--minus-style='syntax #37222c'",
    --           "--minus-non-emph-style='syntax #37222c'",
    --           "--minus-emph-style='syntax #713137'",
    --           "--minus-empty-line-marker-style='syntax #37222c'",
    --           "--line-numbers-minus-style='#914c54'",
    --           "--plus-style='syntax #20303b'",
    --           "--plus-non-emph-style='syntax #20303b'",
    --           "--plus-emph-style='syntax #2c5a66'",
    --           "--plus-empty-line-marker-style='syntax #20303b'",
    --           "--line-numbers-plus-style='#449dab'",
    --           "--line-numbers-zero-style='#3b4261'",
    --           -- "--hunk-header-decoration-style='#45475A ul'",
    --           -- "--dark", -- optional if you want delta in dark mode
    --           "--paging=never", -- optional if you want no pager at all
    --         }, " "),
    --       },
    --     },
    --   },
    -- },
    picker = {
      -- layout = {
      --   -- The default layout for "telescopy" pickers, e.g. `files`, `commands`, ...
      --   -- It will not override non-standard pickers, e.g. `explorer`, `lines`, ...
      --   preset = function()
      --     return vim.o.columns >= 120 and "telescope" or "vertical"
      --   end,
      -- },
      -- layouts = {
      --   telescope = {
      --     -- Copy from https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#telescope
      --     reverse = false,
      --     layout = {
      --       box = "horizontal",
      --       backdrop = false,
      --       width = 0.8, -- Change the width
      --       height = 0.9,
      --       border = "none",
      --       {
      --         box = "vertical",
      --         {
      --           win = "input",
      --           height = 1,
      --           border = "rounded",
      --           title = "{title} {live} {flags}",
      --           title_pos = "center",
      --         },
      --         { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
      --       },
      --       {
      --         win = "preview",
      --         title = "{preview:Preview}",
      --         width = 0.45, -- Change the preview width
      --         border = "rounded",
      --         title_pos = "center",
      --       },
      --     },
      --   },
      -- },
      -- sources = {
      --   files = {},
      --   explorer = {
      --     layout = {
      --       layout = {
      --         position = "right",
      --       },
      --     },
      --   },
      --   lines = {
      --     layout = {
      --       preset = function()
      --         return vim.o.columns >= 120 and "telescope" or "vertical"
      --       end,
      --     },
      --   },
      -- },
      previewers = {
        git = {
          builtin = false,
        },
        diff = {
          builtin = false,
          cmd = {
            "delta",
          },
        },
      },
      -- layouts = {
      -- default = {
      --   layout = {
      --     box = "horizontal",
      --     width = 0.8,
      --     min_width = 120,
      --     height = 0.8,
      --     {
      --       box = "vertical",
      --       border = "single",
      --       title = "{title} {live} {flags}",
      --       { win = "input", height = 1, border = "bottom" },
      --       { win = "list", border = "none" },
      --     },
      --     { win = "preview", title = "{preview}", border = "single", width = 0.5 },
      --   },
      -- },
      -- },
    },
    scope = {
      cursor = false,
    },
    statuscolumn = {
      enabled = true,
      folds = {
        open = true,
        git_hl = true,
      },
    },
    ---@type table<string, snacks.win.Config>
    styles = {
      ---@diagnostic disable-next-line: missing-fields
      -- input = {
      --   border = "single",
      -- },
      ---@diagnostic disable-next-line: missing-fields
      notification = {
        focusable = false,
        -- border = "single",
      },
      ---@diagnostic disable-next-line: missing-fields
      -- notification_history = {
      --   border = "single",
      -- },
      ---@diagnostic disable-next-line: missing-fields
      -- scratch = {
      --   border = "single",
      -- },
      ---@diagnostic disable-next-line: missing-fields
      -- snacks_image = {
      --   border = "single",
      -- },
    },
  },
}
