---@module "snacks"
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "File Explorer (root)",
    },
    {
      "<leader>E",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer (cwd)",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
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
      },
    },
    picker = {
      hidden = true,
      icons = {
        git = {
          ignored = "",
        },
      },
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
      sources = {
        explorer = {
          include = { ".env*" },
          enter = false,
          layout = {
            hidden = { "input" },
            auto_hide = { "input" },
            cycle = false,
          },
          win = {
            input = {
              keys = {
                ["<Esc>"] = "toggle_focus",
              },
            },
            list = {
              keys = {
                ["<Esc>"] = false,
              },
            },
            preview = {
              keys = {
                ["<Esc>"] = false,
              },
            },
          },
        },
        files = {
          hidden = true,
        },
        projects = {
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
    words = {
      enabled = true,
      debounce = 100,
    },

    styles = {
      notification = {
        wo = {
          wrap = true,
        },
      },
    },
  },
}
