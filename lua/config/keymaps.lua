-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })
vim.keymap.set("n", "<leader>gdi", "<cmd>GenerateDotIgnore<cr>", { desc = "Ignore" })
vim.keymap.set("n", "<leader>gds", "<cmd>GenerateDotSpell<cr>", { desc = "Spell" })

vim.keymap.set("n", "<leader>gi", "<cmd>Gitignore<cr>", { desc = "Git Ignore" })

vim.keymap.set("n", "<leader>sf", function()
  Snacks.terminal.toggle("spf")
end, { desc = "Toggle SuperFile" })

-- vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
