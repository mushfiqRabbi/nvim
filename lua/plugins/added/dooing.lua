return {
  "atiladefreitas/dooing",
  event = "VeryLazy",
  config = function()
    require("dooing").setup({
      save_path = vim.fn.expand("~") .. "/dooing_todos.json",
      quick_keys = false,
      keymaps = {
        toggle_window = "<leader>tt",
      },
    })
  end,
}
