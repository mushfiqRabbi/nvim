return {
  "barrett-ruth/live-server.nvim",
  event = "VeryLazy",
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = function()
    require("live-server").setup({})
    -- vim.keymap.set("n", "<leader>ls", "<cmd>LiveServerToggle<cr>", { desc = "Toggle Live Server" })
  end,
}
