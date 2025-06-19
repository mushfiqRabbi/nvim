return {
  "stevearc/oil.nvim",

  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons" } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = true,

  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    use_default_keymaps = false,
    float = {
      padding = 0,
      -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = 0.4,
      max_height = 0.8,
      border = "solid",
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        conf.title = "oil"
        conf.title_pos = "center"
        return conf
      end,
      -- Configuration for the floating progress window
    },
    confirmation = {
      width = 0.6,
      border = "solid",
    },
    progress = {
      width = 0.6,
      border = "solid",
    },
    -- Configuration for the floating SSH window
    ssh = {
      border = "solid",
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
      border = "solid",
    },

    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      -- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      -- ["<C-t>"] = { "actions.select", opts = { tab = true } },
      -- ["<C-p>"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["q"] = { "actions.close", mode = "n" },
      ["<C-l>"] = "actions.refresh",
      ["<BS>"] = { "actions.parent", mode = "n" },
      -- ["_"] = { "actions.open_cwd", mode = "n" },
      -- ["`"] = { "actions.cd", mode = "n" },
      -- ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      -- ["gs"] = { "actions.change_sort", mode = "n" },
      -- ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
  },
}
