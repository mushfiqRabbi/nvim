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

vim.keymap.set("n", "<leader>dd", function()
  Snacks.terminal.toggle("lazydocker")
end, { desc = "Toggle lazydocker" })

vim.keymap.set("n", "<leader>tt", function()
  Snacks.terminal.toggle("btop")
end, { desc = "Toggle btop" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================

-- Remove unwanted default keymaps
vim.keymap.del("n", "<leader>dph")
vim.keymap.del("n", "<leader>dpp")
vim.keymap.del("n", "<leader>dps")
