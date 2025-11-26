-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ============================================================================
-- USER COMMANDS
-- ============================================================================

-- File generation commands for project setup
vim.api.nvim_create_user_command("GenerateDotIgnore", function()
  local root = require("lazyvim.util").root()
  vim.cmd(
    "call writefile(['.git/', '.vscode/', '!.env', '!.env.*', '!.env.*.local', '!.stylelintrc.json'], '"
      .. root
      .. "/.ignore"
      .. "')"
  )
  print("Created .ignore file in " .. root)
end, {})

vim.api.nvim_create_user_command("GenerateDotSpell", function()
  local root = require("lazyvim.util").root()
  vim.cmd("call writefile([], '" .. require("lazyvim.util").root() .. "/.cspell" .. "')")
  vim.cmd("call writefile([], '" .. require("lazyvim.util").root() .. "/.codespell" .. "')")
  print("Created .cspell and .codespell file in " .. root)
end, {})

vim.api.nvim_create_user_command("GenerateDotNoCSpell", function()
  local root = require("lazyvim.util").root()
  vim.cmd("call writefile([], '" .. require("lazyvim.util").root() .. "/.nocspell" .. "')")
  print("Created .nocspell file in " .. root)
end, {})

-- ============================================================================
-- LSP MANAGEMENT
-- ============================================================================

-- Disable bashls for environment files
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local filename = vim.api.nvim_buf_get_name(args.buf)
    if string.match(filename, "%.env.*") then
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == "bashls" then
        client.stop(client, true)
      end
    end
  end,
})

-- Auto-stop LSP clients with no attached buffers
local lsp_detach = {}
local uv = vim.uv

local function stop_client_timeout(client_id, timer)
  timer:start(
    1000 * 60, -- 60 seconds timeout
    0,
    vim.schedule_wrap(function()
      timer:stop()
      if
        not vim.lsp.client_is_stopped(client_id)
        and #(vim.lsp.get_buffers_by_client_id(client_id)) == 0
      then
        vim.notify(
          "***" .. (vim.lsp.get_client_by_id(client_id)).name .. "***" .. ": Stopping lsp client",
          vim.log.levels.INFO,
          { title = "LSP Auto Stop" }
        )
        vim.lsp.stop_client(client_id, true)
      end
      timer:close()
      lsp_detach[client_id] = nil
    end)
  )
end

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("lsp-auto-stop", { clear = true }),
  callback = function(args)
    if not args.data.client_id then
      return
    end

    if not lsp_detach[args.data.client_id] then
      lsp_detach[args.data.client_id] = { timer = uv.new_timer() }
    else
      lsp_detach[args.data.client_id].timer:stop()
    end

    stop_client_timeout(args.data.client_id, lsp_detach[args.data.client_id].timer)
  end,
})

-- Auto-delete completed dooing tasks when vim exits
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Safely try to delete completed tasks
    local success, err = pcall(function()
      local state = require("dooing.state")
      -- Load todos first to ensure we have the current state
      state.load_todos()
      if state and state.todos and #state.todos > 0 then
        state.delete_completed()
      end
    end)

    if not success then
      -- Only notify if dooing module exists but had an error
      -- Don't show error if dooing simply isn't installed
      local module_exists, _ = pcall(require, "dooing.state")
      if module_exists then
        vim.notify(
          "Error auto-deleting completed tasks: " .. tostring(err),
          vim.log.levels.WARN,
          { title = "Dooing" }
        )
      end
    end
  end,
})

-- Fyler cross-root follow functionality
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Only run if fyler is currently open and we're in a regular file buffer
    local current_buf = vim.api.nvim_get_current_buf()
    local current_buf_name = vim.api.nvim_buf_get_name(current_buf)
    local buftype = vim.bo[current_buf].buftype

    -- Skip for special buffer types (pickers, terminals, help, etc.)
    if buftype ~= "" and buftype ~= "acwrite" then
      return
    end

    -- Skip for fyler buffers
    local is_fyler_buf = current_buf_name:match("^fyler://")
    if is_fyler_buf then
      return
    end

    -- Get current file's directory and the project root
    local current_file_dir = vim.fn.fnamemodify(current_buf_name, ":p:h")
    local project_root = require("lazyvim.util").root()

    -- Check if fyler is currently open
    local fyler = require("fyler")
    local finder_mgr = require("fyler.views.finder")

    if finder_mgr._current then
      -- Store the original window and buffer at the beginning to be restored later
      local original_win = vim.api.nvim_get_current_win()
      local original_buf = vim.api.nvim_get_current_buf()

      -- Get the directory of the current fyler instance
      local current_fyler_dir = finder_mgr._current.dir

      -- Check if current file is in a different project root
      local current_file_in_fyler_dir =
        vim.startswith(current_file_dir .. "/", current_fyler_dir .. "/")
      local fyler_dir_in_current_file =
        vim.startswith(current_fyler_dir .. "/", current_file_dir .. "/")

      -- If the current file is not under the same project root as the current fyler instance
      if not current_file_in_fyler_dir and not fyler_dir_in_current_file then
        -- Close current instance and open new one with the correct root
        finder_mgr.close()
        fyler.open({ dir = project_root })
      end

      -- Navigate to the current file in fyler without changing focus to fyler
      if vim.bo.buftype == '' then
        if finder_mgr._current then
          fyler.navigate(current_buf_name)
        end
      end

      -- Restore focus to the original window after all operations
      -- Use a small delay to ensure all internal operations complete first
      vim.defer_fn(function()
        if vim.api.nvim_win_is_valid(original_win) and vim.api.nvim_buf_is_valid(original_buf) then
          vim.api.nvim_set_current_win(original_win)
        end
      end, 0)  -- Minimal delay to allow operations to complete
    end
  end,
  desc = "Update fyler to follow current file across project roots",
})
