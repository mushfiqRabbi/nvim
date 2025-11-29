-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ============================================================================
-- CURSOR CONFIGURATION
-- ============================================================================

vim.opt.guicursor = {
  "n-v-c-sm:block-blinkon500-blinkoff500",
  "i-ci-ve:ver25-blinkon500-blinkoff500",
  "r-cr-o:hor20-blinkon500-blinkoff500",
  "t:block-blinkon500-blinkoff500-TermCursor",
  "c-t:ver25-blinkon500-blinkoff500",
}

-- ============================================================================
-- PROJECT ROOT DETECTION
-- ============================================================================

vim.g.root_spec = {
  "lsp",
  {
    ".git",
    "_darcs",
    ".hg",
    ".bzr",
    ".svn",
    "Makefile",
    "package.json",
    "lua",
    ".root",
  },
  "cwd",
}

-- ============================================================================
-- EDITOR BEHAVIOR
-- ============================================================================

vim.opt.sidescrolloff = 0
vim.opt.wrap = true
vim.opt.ttimeoutlen = 0

-- ============================================================================
-- LAZYVIM CONFIGURATION
-- ============================================================================

vim.g.lazyvim_prettier_needs_config = false

-- ============================================================================
-- DIAGNOSTIC CONFIGURATION
-- ============================================================================

vim.diagnostic.config({
  virtual_text = false,
})
