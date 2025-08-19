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

vim.keymap.set("n", "<leader>lg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

vim.keymap.set("n", "<leader>ld", function()
  Snacks.terminal.toggle("lazydocker")
end, { desc = "Lazydocker" })

vim.keymap.set("n", "<leader>bt", function()
  Snacks.terminal.toggle("btop")
end, { desc = "Toggle btop" })

vim.keymap.set("n", "<leader>li", function()
  Snacks.picker.lsp_config({
    attached = 0,
  })
end, { desc = "LSP Info" })

vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })

vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })

vim.keymap.set("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })

vim.keymap.set("n", "<leader>fs", function()
  Snacks.scratch.select()
end, { desc = "Find Scratch Buffer" })

-- ============================================================================
-- AI
-- ============================================================================

vim.keymap.set("n", "<leader>ad", function()
  -- Get current buffer and file information
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Get diagnostics for the current line
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_number = cursor[1] - 1 -- Convert to 0-indexed

  -- Get all diagnostics for the buffer
  local diagnostics = vim.diagnostic.get(bufnr)

  -- Find diagnostics on the current line
  local line_diagnostics = {}
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.lnum == line_number then
      table.insert(line_diagnostics, diagnostic)
    end
  end

  -- Check if buffer has unsaved changes
  local is_modified = vim.bo[bufnr].modified

  -- Build the prompt
  local prompt = "Analyze diagnostics for: " .. filename .. "\n\n"

  if #line_diagnostics > 0 then
    prompt = prompt .. "Line " .. (line_number + 1) .. " diagnostics:\n"
    for _, diagnostic in ipairs(line_diagnostics) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      prompt = prompt .. "- [" .. severity .. "] " .. diagnostic.message .. "\n"
    end
    prompt = prompt .. "\n"

    if is_modified then
      -- Context around the problematic line
      local context_lines = 5
      local start_line = math.max(0, line_number - context_lines)
      local end_line = math.min(#lines - 1, line_number + context_lines)

      local context_content = {}
      for i = start_line, end_line do
        local line_prefix = (i == line_number) and ">>> " or "    "
        table.insert(
          context_content,
          string.format("%3d%s%s", i + 1, line_prefix, lines[i + 1] or "")
        )
      end
      local context = table.concat(context_content, "\n")

      prompt = prompt .. "Context (unsaved changes):\n" .. context .. "\n\n"
    end

    prompt = prompt
      .. "Provide a highly concise, structured response covering: issue, cause, and fix.\n"
    prompt = prompt
      .. "Use clear section headings with visual separators (=== or ---) and bullet points.\n\n"
    prompt = prompt .. "DO NOT implement changes automatically. Only analyze and guide.\n"
    prompt = prompt
      .. "If asked to implement: make changes, save file, run language checks, report results.\n"
  else
    prompt = prompt
      .. "No diagnostics on line "
      .. (line_number + 1)
      .. ". Run language checks to verify file integrity."
  end

  -- Execute the command
  local escaped_prompt = vim.fn.shellescape(prompt)
  Snacks.terminal.open("mise x node@latest -- qwen -i " .. escaped_prompt, {
    win = {
      position = "right",
    },
  })
end, { desc = "AI Diagnostics Analysis" })

-- Keymap for all buffer diagnostics
vim.keymap.set("n", "<leader>aD", function()
  -- Get current buffer and file information
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Get all diagnostics for the buffer
  local diagnostics = vim.diagnostic.get(bufnr)

  -- Check if buffer has unsaved changes
  local is_modified = vim.bo[bufnr].modified

  -- Build the prompt
  local prompt = "Analyze ALL diagnostics for: " .. filename .. "\n\n"

  if #diagnostics > 0 then
    prompt = prompt .. "Found " .. #diagnostics .. " issues:\n"

    -- Group diagnostics by line
    local diagnostics_by_line = {}
    for _, diagnostic in ipairs(diagnostics) do
      local line_num = diagnostic.lnum + 1
      if not diagnostics_by_line[line_num] then
        diagnostics_by_line[line_num] = {}
      end
      table.insert(diagnostics_by_line[line_num], diagnostic)
    end

    -- Display diagnostics by line
    for line_num, line_diagnostics in pairs(diagnostics_by_line) do
      prompt = prompt .. "Line " .. line_num .. ":\n"
      for _, diagnostic in ipairs(line_diagnostics) do
        local severity = vim.diagnostic.severity[diagnostic.severity]
        prompt = prompt .. "  - [" .. severity .. "] " .. diagnostic.message .. "\n"
      end
    end
    prompt = prompt .. "\n"

    if is_modified then
      -- Show context around problematic lines
      local context_lines = 3
      local context_sections = {}

      local diagnostic_lines = {}
      for _, diagnostic in ipairs(diagnostics) do
        diagnostic_lines[diagnostic.lnum] = true
      end

      for line_num, _ in pairs(diagnostic_lines) do
        local start_line = math.max(0, line_num - context_lines)
        local end_line = math.min(#lines - 1, line_num + context_lines)

        local section_content = {}
        table.insert(section_content, "Context around line " .. (line_num + 1) .. ":")
        for i = start_line, end_line do
          local line_prefix = (i == line_num) and ">>> " or "    "
          table.insert(
            section_content,
            string.format("%3d%s%s", i + 1, line_prefix, lines[i + 1] or "")
          )
        end
        table.insert(context_sections, table.concat(section_content, "\n"))
      end

      prompt = prompt
        .. "Context (unsaved changes):\n"
        .. table.concat(context_sections, "\n\n")
        .. "\n\n"
    end

    prompt = prompt
      .. "Provide a highly concise, structured analysis covering: overview, issue breakdown, and priorities.\n"
    prompt = prompt
      .. "Use clear section headings with visual separators (=== or ---) and bullet points.\n\n"
    prompt = prompt .. "DO NOT implement changes automatically. Only analyze and guide.\n"
    prompt = prompt
      .. "If asked to implement: make changes in priority order, save file, run language checks, report results.\n"
  else
    prompt = prompt .. "No diagnostics found. Run language checks to verify file integrity."
  end

  -- Execute the command
  local escaped_prompt = vim.fn.shellescape(prompt)
  Snacks.terminal.open("mise x node@latest -- qwen -i " .. escaped_prompt, {
    win = {
      position = "right",
    },
  })
end, { desc = "AI Analysis of All Buffer Diagnostics" })

-- ============================================================================
-- DELETED KEYMAPS
-- ============================================================================

-- Remove unwanted default keymaps
vim.keymap.del("n", "<leader>dph")
vim.keymap.del("n", "<leader>dpp")
vim.keymap.del("n", "<leader>dps")
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>td")
vim.keymap.del("n", "<leader>tD")
