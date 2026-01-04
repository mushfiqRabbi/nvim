-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ============================================================================
-- AI
-- ============================================================================

-- Load AI utility module
local ai = require("util.ai")

-- Keymaps for AI context assistant
vim.keymap.set({ "n", "v" }, "<leader>ai", function()
  -- Set kitty layout to splits
  vim.system({ "kitty", "@", "goto-layout", "splits" })

  ai.launch_ai({ type = "window" })
end, { desc = "AI Context Assistant" })

vim.keymap.set({ "n", "v" }, "<leader>aI", function()
  ai.launch_ai({ type = "tab" })
end, { desc = "AI Context Assistant (New Tab)" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================

vim.keymap.del("n", "<leader>td")
vim.keymap.del("n", "<leader>tD")
