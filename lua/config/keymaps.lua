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
  local servername = vim.v.servername or ""
  if servername ~= "" then
    Snacks.terminal("yazi", {
      win = { border = "solid" },
      env = { NVIM_LISTEN_ADDRESS = servername },
    })
  else
    Snacks.terminal("yazi", {
      win = { border = "solid" },
    })
    vim.notify(
      "NVIM_LISTEN_ADDRESS not available. Start Neovim with --listen for editor integration.",
      vim.log.levels.WARN
    )
  end
end, { desc = "Yazi File Manager (with Neovim socket)" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================

vim.keymap.del("n", "<leader>td")
vim.keymap.del("n", "<leader>tD")
