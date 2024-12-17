-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = "n-v-sm:block,r:hor20,i-c-ci:ver25,a:blinkwait0-blinkoff500-blinkon500"
vim.g.root_spec = { "lsp", { ".git", "lua", ".root" }, "cwd" }
vim.opt.sidescrolloff = 0
vim.opt.wrap = true
-- vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_prettier_needs_config = false

-- vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

vim.filetype.add({
  -- Detect and assign filetype based on the extension of the filename
  --   extension = {
  --     log = "log",
  --     conf = "conf",
  --     env = "dotenv",
  --   },
  -- Detect and apply filetypes based on the entire filename
  -- filename = {
  --   [".env"] = "dotenv",
  --   ["env"] = "dotenv",
  -- },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO Match filenames like - ".env.example", ".env.local" and so on
    ["%.?env[%.%w_.-]*"] = "sh",
  },
})
