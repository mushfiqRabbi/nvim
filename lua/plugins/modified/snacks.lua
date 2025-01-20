return {
  "folke/snacks.nvim",
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
    statuscolumn = {
      enabled = true,
      folds = {
        open = true,
        git_hl = true,
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
    scope = {
      cursor = false,
    },

    styles = {
      notification = {
        relative = "editor",
        focusable = false,
      },
    },
  },
}
