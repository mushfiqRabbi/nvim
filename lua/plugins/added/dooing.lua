return {
  "atiladefreitas/dooing",
  event = "VeryLazy",
  config = function()
    require("dooing").setup({
      save_path = vim.fn.expand("~") .. "/.dooing_global.json",
      quick_keys = false,
      per_project = {
        default_filename = ".dooing_local.json",
        on_missing = "auto_create",
      },
      keymaps = {
        toggle_window = "<leader>tT",
        open_project_todo = "<leader>tt",
      },
    })
  end,
}
