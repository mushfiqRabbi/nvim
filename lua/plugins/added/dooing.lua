return {
  "atiladefreitas/dooing",
  event = "VeryLazy",
  opts = {
    save_path = vim.fn.expand("~") .. "/.dooing_global.json",
    pretty_print_json = true, -- Pretty-print JSON output (requires jq or python)
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
    notes = {
      icon = "",
    },
    per_project = {
      default_filename = ".dooing_local.json",
      on_missing = "auto_create",
    },
    nested_tasks = {
      indent = 3,
    },
    priorities = {
      {
        name = "important",
        weight = 4,
      },
      {
        name = "urgent",
        weight = 2,
      },
      {
        name = " ",
        weight = -1,
      },
    },
    priority_groups = {
      lowest = {
        members = { " " },
        hl_group = "IndentLight",
      },
    },
    keymaps = {
      toggle_window = "<leader>tt", -- Toggle global todos
      open_project_todo = "<leader>tT", -- Toggle project-specific todos
      create_nested_task = "n",
    },
  },
}
