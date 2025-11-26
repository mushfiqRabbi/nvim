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
          name = "signal",
          weight = 12,
        },
        {
          name = "important",
          weight = 4,
        },
        {
          name = "urgent",
          weight = 2,
        },
      },
      priority_groups = {
        max = {
          members = {},
          color = nil,
          hl_group = "DiagnosticHint",
        },
        high = {
          members = { "important", "urgent" },
          color = nil,
          hl_group = "DiagnosticError",
        },
        medium = {
          members = { "important" },
          color = nil,
          hl_group = "DiagnosticWarn",
        },
        low = {
          members = { "urgent" },
          color = nil,
          hl_group = "DiagnosticInfo",
        },
      },
      keymaps = {
        create_nested_task = "n",
      },
    })
  end,
}
