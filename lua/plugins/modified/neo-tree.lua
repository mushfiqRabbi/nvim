return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    filesystem = {
      bind_to_cwd = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
          ".vscode",
        },
        always_show = {
          ".env",
          ".env.local",
          ".ignore",
          ".cspell",
        },
      },
    },
    window = {
      mappings = { ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } } },
    },
    event_handlers = {
      {
        event = "file_added",
        handler = function(path)
          require("neo-tree.command").execute({
            reveal_file = path,
          })
        end,
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ action = "show", toggle = true, dir = LazyVim.root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ action = "show", toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  },
}
