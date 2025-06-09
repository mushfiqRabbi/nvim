return {
  "mushfiqRabbi/arrow.nvim",
  -- event = "VeryLazy",
  dependencies = {
    -- { "nvim-tree/nvim-web-devicons" },
    -- or if using `mini.icons`
    { "echasnovski/mini.icons" },
  },
  opts = {
    show_icons = true,
    separate_by_branch = true,
    leader_key = ";",
    buffer_leader_key = "m",
    hide_handbook = true,
    hide_buffer_handbook = true,
    separate_save_and_remove = true,
    save_key = "git_root",
    mappings = {
      next_item = "n",
      prev_item = "p",
    },
  },
}
