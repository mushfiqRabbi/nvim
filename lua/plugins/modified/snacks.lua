return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>/",
      -- function()
      --   Snacks.picker.lines()
      -- end,
      -- desc = "Buffer Lines",
      false,
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
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
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
        char = {
          corner_top = "┌",
          corner_bottom = "└",
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
    },
    lazygit = {
      config = {
        gui = {
          border = "single",
        },
      },
    },
    picker = {
      layouts = {
        default = {
          layout = {
            box = "horizontal",
            width = 0.8,
            min_width = 120,
            height = 0.8,
            {
              box = "vertical",
              border = "single",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = "single", width = 0.5 },
          },
        },
      },
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
      input = {
        border = "single",
      },
      ---@diagnostic disable-next-line: missing-fields
      notification = {
        focusable = false,
        border = "single",
      },
      ---@diagnostic disable-next-line: missing-fields
      notification_history = {
        border = "single",
      },
      ---@diagnostic disable-next-line: missing-fields
      scratch = {
        border = "single",
      },
      ---@diagnostic disable-next-line: missing-fields
      snacks_image = {
        border = "single",
      },
    },
  },
}
