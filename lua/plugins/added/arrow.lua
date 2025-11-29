return {
  -- NOTE: FORKED
  "mushfiqRabbi/arrow.nvim",
  dependencies = {
    { "nvim-mini/mini.icons" },
  },
  keys = {
    {
      ";",
      function()
        require("ui").openMenu()
      end,
      desc = "Arrow File Mappings",
      nowait = true,
    },
    {
      ",",
      function()
        require("arrow.buffer_ui").openMenu()
      end,
      desc = "Arrow Buffer Mappings",
      nowait = true,
    },
  },
  opts = {
    show_icons = true,
    leader_key = ";",
    buffer_leader_key = ",",
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
