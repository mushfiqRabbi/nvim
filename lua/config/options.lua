-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = vim.opt.guicursor + "c-t:ver25"
-- vim.opt.guicursor = "n-v-sm:block,r:hor20,i-c-ci:ver25,a:blinkwait0-blinkoff500-blinkon500"
vim.g.root_spec = { "lsp", { ".git", "lua", ".root" }, "cwd" }
vim.opt.sidescrolloff = 0
vim.opt.wrap = true
-- vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_prettier_needs_config = false

-- vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

-- vim.diagnostic.config({
--   virtual_text = true,
--   virtual_lines = { current_line = true },
--   underline = true,
--   update_in_insert = false,
-- })

-- vim.filetype.add({
--   -- Detect and assign filetype based on the extension of the filename
--   --   extension = {
--   --     log = "log",
--   --     conf = "conf",
--   --     env = "dotenv",
--   --   },
--   -- Detect and apply filetypes based on the entire filename
--   -- filename = {
--   --   [".env"] = "dotenv",
--   --   ["env"] = "dotenv",
--   -- },
--   -- Detect and apply filetypes based on certain patterns of the filenames
--   pattern = {
--     -- INFO Match filenames like - ".env.example", ".env.local" and so on
--     ["%.?env[%.%w_.-]*"] = "sh",
--   },
-- })

-- NOTE: shade and tint from https://maketintsandshades.com/#3b4261
vim.api.nvim_set_hl(0, "IndentDark", { fg = "#292e44" }) -- 30% shade

-- NOTE: When kitty text_composition_strategy is set to "platform"
vim.api.nvim_set_hl(0, "IndentLight", { fg = "#353b57" }) -- 30% shade

-- NOTE: When kitty text_composition_strategy is set to "legacy"
--  vim.api.nvim_set_hl(0, "IndentLight", { fg = "#4f5571" }) -- 10% tint

-- NOTE: shade and tint from https://maketintsandshades.com/#292e42
vim.cmd("hi MatchParen guibg=#545868") -- 20% tint
