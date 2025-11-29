---@module "vscode-diff"
return {
  "esmuellert/vscode-diff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  keys = {
    {
      "<leader>dF",
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
        toggle_explorer = false, -- Toggle explorer visibility (explorer mode only)
        next_hunk = "[c", -- Jump to next change
        prev_hunk = "]c", -- Jump to previous change
        next_file = "[f", -- Next file in explorer mode
        prev_file = "]f", -- Previous file in explorer mode
      },
    },
  },
}
