return {
  "mushfiqRabbi/arrow.nvim",
  dependencies = {
    { "echasnovski/mini.icons" },
  },
  opts = {
    show_icons = true,
    leader_key = ";",
    buffer_leader_key = "m",
    separate_save_and_remove = true,
    global_bookmarks = true,
    per_buffer_config = {
      lines = 5,
    },
    mappings = {
      toggle = "a",
      open_horizontal = "s",
      next_item = "n",
      prev_item = "p",
      remove = "r",
    },
  },
}
