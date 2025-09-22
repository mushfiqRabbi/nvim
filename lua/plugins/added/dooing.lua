return {
  "atiladefreitas/dooing",
  event = "VeryLazy",
  config = function()
    require("dooing").setup({
      save_path = vim.fn.expand("~") .. "/.dooing_global.json",
      timestamp = {
        enabled = false,
      },
      window = {
        width = 100,
      },
      formatting = {
        pending = {
          icon = " ",
        },
        in_progress = {
          icon = " ",
        },
        done = {
          icon = " ",
        },
      },
      quick_keys = false,
      per_project = {
        default_filename = ".dooing_local.json",
        on_missing = "auto_create",
      },
      nested_tasks = {
        indent = 3,
      },
      -- keymaps = {
      --   toggle_window = "<leader>tg",
      --   open_project_todo = "<leader>tl",
      --   delete_todo = "d",
      -- },
    })
  end,
}
