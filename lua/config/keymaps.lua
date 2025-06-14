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

vim.keymap.set("n", "<leader>ai", function()
  local function get_current_file()
    local path = vim.api.nvim_buf_get_name(0)
    return path ~= "" and path or nil
  end

  local function make_text_prompt(file)
    return table.concat({
      "Please view the file located at " .. file .. ".",
      "After viewing, print *only* the absolute path to this file,",
      "and then acknowledge that you are ready for the next prompt.",
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
