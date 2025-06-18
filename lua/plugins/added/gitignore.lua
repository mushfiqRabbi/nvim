return {
  "wintermute-cell/gitignore.nvim",
  keys = {
    {
      "<leader>gi",
      "<cmd>Gitignore<cr>",
      desc = "Git Ignore",
      mode = "n",
    },
  },
  config = function()
    require("gitignore")
  end,
}
