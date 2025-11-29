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

  local prompt = ai.generate_ai_context()
  ai.launch_ai(prompt, { type = "window" })
end, { desc = "AI Context Assistant" })

vim.keymap.set({ "n", "v" }, "<leader>aI", function()
  local prompt = ai.generate_ai_context()
  ai.launch_ai(prompt, { type = "tab" })
end, { desc = "AI Context Assistant (New Tab)" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================
