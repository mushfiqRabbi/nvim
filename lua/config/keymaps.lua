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
-- TERMINAL
-- ============================================================================

-- Open yazi file manager in snacks terminal with Neovim socket
vim.keymap.set("n", "<leader>fy", function()
  local current_file = vim.fn.expand("%:p")
  local buftype = vim.bo.buftype
  local servername = vim.v.servername

  local yazi_cmd = "yazi"

  if buftype == "" and current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
    yazi_cmd = string.format("yazi %s", vim.fn.shellescape(current_file))
  end

  local opts = {
    win = { border = "solid" },
  }

  if servername and servername ~= "" then
    opts.env = { NVIM_LISTEN_ADDRESS = servername }
  end

  Snacks.terminal(yazi_cmd, opts)
end, { desc = "Yazi File Manager" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================

vim.keymap.del("n", "<leader>td")
vim.keymap.del("n", "<leader>tD")
