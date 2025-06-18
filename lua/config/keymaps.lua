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
-- AI INTEGRATION
-- ============================================================================

vim.keymap.set("n", "<leader>ai", function()
  local function get_current_file()
    local path = vim.api.nvim_buf_get_name(0)
    return path ~= "" and path or nil
  end

  local function make_text_prompt(file)
    return table.concat({
      "The following is the absolute path of the file currently open in my Neovim editor:",
      file .. ".",
      "For now, just store this path for context—do not view or analyze the file yet.",
      "Simply print the absolute path exactly as-is, and confirm that you're ready for the next prompt.",
      "In future prompts, you may use this file context if necessary, depending on the question I ask.",
    }, " ")
  end

  local function run_goose_in_kitty(prompt)
    vim.system({
      "kitten",
      "@",
      "launch",
      "--type=window",
      "--location=vsplit",
      "--bias=30",
      "--cwd=current",
      "zsh",
      "-ic",
      string.format('goose run -t "%s" -s', prompt),
    })
  end

  local file = get_current_file()
  if not file then
    vim.notify("No file open in current buffer", vim.log.levels.WARN)
    return
  end

  local prompt = make_text_prompt(file)
  run_goose_in_kitty(prompt)
end, { desc = "Ai" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================

-- Remove unwanted default keymaps
vim.keymap.del("n", "<leader>dph")
vim.keymap.del("n", "<leader>dpp")
vim.keymap.del("n", "<leader>dps")
