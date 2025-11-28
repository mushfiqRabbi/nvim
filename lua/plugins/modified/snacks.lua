---@module "snacks"
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
      "<leader>rn",
      function()
        Snacks.words.jump(1, true)
      end,
      mode = { "n" },
      desc = "Next Word",
    },
    {
      "<leader>rp",
      function()
        Snacks.words.jump(-1, true)
      end,
      mode = { "n" },
      desc = "Previous Word",
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
    -- bigfile = {
    --   line_length = 100000,
    -- },
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
