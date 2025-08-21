-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ============================================================================
-- FILE GENERATION
-- ============================================================================

vim.keymap.set("n", "<leader>di", "<cmd>GenerateDotIgnore<cr>", { desc = "Generate .ignore" })
vim.keymap.set("n", "<leader>ds", "<cmd>GenerateDotNoCSpell<cr>", { desc = "Generate .nocspell" })

-- ============================================================================
-- TERMINAL TOGGLES
-- ============================================================================

vim.keymap.set("n", "<leader>lg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>ld", function()
  Snacks.terminal.toggle("lazydocker")
end, { desc = "Lazydocker" })

vim.keymap.set("n", "<leader>bt", function()
  Snacks.terminal.toggle("btop")
end, { desc = "Toggle btop" })

vim.keymap.set("n", "<leader>li", function()
  Snacks.picker.lsp_config({
    attached = 0,
  })
end, { desc = "LSP Info" })

vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })

vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })

vim.keymap.set("n", "<leader>fs", function()
  Snacks.scratch.select()
end, { desc = "Find Scratch Buffer" })

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

-- Remove unwanted default keymaps
vim.keymap.del("n", "<leader>dph")
vim.keymap.del("n", "<leader>dpp")
vim.keymap.del("n", "<leader>dps")
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>td")
vim.keymap.del("n", "<leader>tD")

