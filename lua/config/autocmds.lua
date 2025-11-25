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
        vim.notify("Error auto-deleting completed tasks: " .. tostring(err), vim.log.levels.WARN, { title = "Dooing" })
      end
    end
  end,
})
