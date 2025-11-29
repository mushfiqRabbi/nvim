---@module "snacks"
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "File Explorer",
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
          enter = false,
          layout = {
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
                ["<c-m>"] = "toggle_maximize",
                ["<c-w><c-w>"] = function(_)
                  vim.cmd("wincmd w")
                  vim.cmd("wincmd w")
                end,
                ["<c-w>w"] = function(_)
                  vim.cmd("wincmd w")
                  vim.cmd("wincmd w")
                end,
              },
            },
            preview = {
              keys = {
                ["<Esc>"] = false,
              },
            },
          },
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
  },
}
