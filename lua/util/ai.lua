-- AI utility functions for Qwen Code
local M = {}

-- Helper function to generate AI context
function M.generate_ai_context()
  local mode = vim.api.nvim_get_mode().mode
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line_number = cursor[1]

  -- Get all diagnostics for the buffer
  local diagnostics = vim.diagnostic.get(bufnr)

  local prompt = "Context Information:\n\n"
  prompt = prompt .. "File: " .. filename .. "\n"
  prompt = prompt .. "Current line: " .. line_number .. "\n\n"

  if mode == "n" then
    -- Normal mode behavior
    prompt = prompt .. "Mode: Normal\n\n"

    -- Check if buffer has unsaved changes and get content if needed
    local is_modified = vim.bo[bufnr].modified
    if is_modified then
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local context_lines = 3
      local start_line = math.max(1, line_number - context_lines)
      local end_line = math.min(#lines, line_number + context_lines)

      prompt = prompt .. "Buffer content around current line (unsaved changes):\n"
      for i = start_line, end_line do
        local line_prefix = (i == line_number) and ">>> " or "    "
        prompt = prompt .. string.format("%3d%s%s\n", i, line_prefix, lines[i] or "")
      end
      prompt = prompt .. "\n"
    else
      prompt = prompt .. "Buffer: No unsaved changes\n\n"
    end
  elseif mode == "v" or mode == "V" or mode == "\22" then -- visual modes
    -- Visual mode behavior
    prompt = prompt .. "Mode: Visual\n\n"

    -- Get selected text using a more reliable method
    local selected_text = ""

    -- Exit visual mode to get proper marks, then get the text
    vim.cmd("normal! \27") -- ESC to exit visual mode

    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local start_col = start_pos[3]
    local end_line = end_pos[2]
    local end_col = end_pos[3]

    if mode == "V" then
      -- Visual line mode - get entire lines
      local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
      selected_text = table.concat(lines, "\n")
    elseif start_line == end_line then
      -- Single line selection
      local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1] or ""
      if start_col <= end_col and start_col <= #line then
        selected_text = line:sub(start_col, end_col)
      end
    else
      -- Multi-line selection
      local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
      if #lines > 0 then
        -- Trim first line from start_col
        lines[1] = lines[1]:sub(start_col)
        -- Trim last line to end_col
        if #lines > 1 then
          lines[#lines] = lines[#lines]:sub(1, end_col)
        end
        selected_text = table.concat(lines, "\n")
      end
    end

    prompt = prompt .. "Selected text:\n"
    prompt = prompt .. "```\n" .. selected_text .. "\n```\n\n"
  end

  -- Check if current line has diagnostics
  local current_line_diagnostics = {}
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.lnum + 1 == line_number then
      table.insert(current_line_diagnostics, diagnostic)
    end
  end

  -- Add diagnostics information
  if #diagnostics > 0 then
    prompt = prompt .. "Diagnostics (" .. #diagnostics .. " issues):\n"

    -- Group diagnostics by line
    local diagnostics_by_line = {}
    for _, diagnostic in ipairs(diagnostics) do
      local diag_line = diagnostic.lnum + 1
      if not diagnostics_by_line[diag_line] then
        diagnostics_by_line[diag_line] = {}
      end
      table.insert(diagnostics_by_line[diag_line], diagnostic)
    end

    -- Display diagnostics by line
    for diag_line, line_diagnostics in pairs(diagnostics_by_line) do
      prompt = prompt .. "Line " .. diag_line .. ":\n"
      for _, diagnostic in ipairs(line_diagnostics) do
        local severity = vim.diagnostic.severity[diagnostic.severity]
        prompt = prompt .. "  - [" .. severity .. "] " .. diagnostic.message .. "\n"
      end
    end
    prompt = prompt .. "\n"
  else
    prompt = prompt .. "Diagnostics: No issues found\n\n"
  end

  prompt = prompt .. "=== CONTEXT PROVIDED ===\n\n"

  if #current_line_diagnostics > 0 then
    -- Current line has diagnostics - allow analysis
    local is_modified = vim.bo[bufnr].modified

    prompt = prompt .. "CURRENT LINE HAS DIAGNOSTICS - Please analyze and provide:\n"
    prompt = prompt .. "1. What is causing each diagnostic issue\n"
    prompt = prompt .. "2. How to solve each issue\n"
    prompt = prompt .. "3. Use any structured format you prefer (headings, bullets, etc.)\n"

    if is_modified then
      -- File has unsaved changes, diagnostics might be from unsaved changes
      prompt = prompt
        .. "4. Note: File has unsaved changes - provide guidance only (no implementation offers)\n\n"
    else
      -- File is saved, agent can read the file to see the actual problematic code
      prompt = prompt
        .. "4. After your analysis, ask if I would like you to implement the fixes\n\n"
    end

    prompt = prompt .. "Current line diagnostics:\n"
    for _, diagnostic in ipairs(current_line_diagnostics) do
      local severity = vim.diagnostic.severity[diagnostic.severity]
      prompt = prompt .. "- [" .. severity .. "] " .. diagnostic.message .. "\n"
    end
  else
    -- No diagnostics on current line - wait for instructions
    prompt = prompt .. "IMPORTANT: Do not analyze, read files, or take any action yet.\n"
    prompt = prompt
      .. "Simply acknowledge you have received this context and wait for my specific request.\n"
    prompt = prompt .. "Respond only with: 'Context received. What would you like me to do?'"
  end

  return prompt
end

-- Helper function to launch AI with specific configuration
function M.launch_ai(prompt, config)
  local cmd = { "kitten", "@", "launch", "--type=" .. config.type }

  -- Add window-specific options
  if config.type == "window" then
    table.insert(cmd, "--location=vsplit")
    table.insert(cmd, "--bias=40")
  end

  -- Add common options and command
  vim.list_extend(cmd, {
    "--cwd=current",
    "zsh",
    "-ic",
    "mise x node@latest -- qwen -i " .. vim.fn.shellescape(prompt),
  })

  vim.system(cmd)
end

return M
