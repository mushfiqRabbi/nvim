return {
  "kylechui/nvim-surround",
 version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = false,
        insert_line = false,
      },
      move_cursor = false,
    })
  end,
}
