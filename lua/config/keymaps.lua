-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })
vim.keymap.set("n", "<leader>di", "<cmd>GenerateDotIgnore<cr>", { desc = "Generate .ignore" })
-- vim.keymap.set("n", "<leader>gds", "<cmd>GenerateDotSpell<cr>", { desc = "Spell" })
vim.keymap.set("n", "<leader>ds", "<cmd>GenerateDotNoCSpell<cr>", { desc = "Generate .nocspell" })

vim.keymap.set("n", "<leader>gi", "<cmd>Gitignore<cr>", { desc = "Git Ignore" })

vim.keymap.set("n", "<leader>dd", function()
  Snacks.terminal.toggle("lazydocker")
end, { desc = "Toggle lazydocker" })

vim.keymap.set("n", "<leader>tt", function()
  Snacks.terminal.toggle("btop")
end, { desc = "Toggle btop" })

-- vim.keymap.set("n", "<leader>sf", function()
--   Snacks.terminal.toggle("spf")
-- end, { desc = "Toggle SuperFile" })

-- vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- vim.keymap.set("n", "<leader>dl", function()
--   local new_config = not vim.diagnostic.config().virtual_lines
--   -- vim.diagnostic.config({ virtual_lines = new_config and { current_line = true } or false })
--   vim.diagnostic.config({ virtual_lines = new_config })
--   vim.diagnostic.config({ virtual_text = not new_config })
-- end, { desc = "Toggle diagnostic virtual_lines" })

-- NOTE: DELETED KEYMAPS
--
vim.keymap.del("n", "<leader>dph")
vim.keymap.del("n", "<leader>dpp")
vim.keymap.del("n", "<leader>dps")
