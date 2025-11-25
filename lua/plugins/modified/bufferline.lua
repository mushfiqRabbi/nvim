return {
  "akinsho/bufferline.nvim",
  event = "BufEnter",
  opts = {
    options = {
      always_show_bufferline = true,
      sort_by = "insert_after_current",
      offsets = {
        {
          filetype = "fyler",
          text = "--- Fyler ---",
          text_align = "center",
          separator = true,
        },
      },
    },
  },
}
