---@module "vscode-diff"
return {
  "esmuellert/vscode-diff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    {
      "<leader>dr",
      "<cmd>CodeDiff<cr>",
      desc = "Diff Repository",
    },
    {
      "<leader>df",
      "<cmd>CodeDiff file HEAD<cr>",
      desc = "Diff File",
    },
  },
  opts = {
    keymaps = {
      view = {
        quit = "q", -- Close diff tab
        toggle_explorer = false, -- Toggle explorer visibility (explorer mode only)
        next_hunk = "[c", -- Jump to next change
        prev_hunk = "]c", -- Jump to previous change
        next_file = "[f", -- Next file in explorer mode
        prev_file = "]f", -- Previous file in explorer mode
      },
      explorer = {
        select = "<CR>", -- Open diff for selected file
        hover = "K", -- Show file diff preview
        refresh = "R", -- Refresh git status
      },
    },
  },
}
