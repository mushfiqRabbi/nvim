-- AI utility functions for Qwen Code
local M = {}

-- Helper function to launch AI with specific configuration
function M.launch_ai(config)
  local cmd = { "kitten", "@", "launch", "--type=" .. config.type }

  -- Add window-specific options
  if config.type == "window" then
    table.insert(cmd, "--location=vsplit")
    table.insert(cmd, "--bias=45")
  end

  -- Add common options and command
  vim.list_extend(cmd, {
    "--cwd=current",
    "opencode",
  })

  vim.system(cmd)
end

return M
