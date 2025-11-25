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

-- ============================================================================
-- BUFFER MANAGEMENT
-- ============================================================================

-- Track LazyVim root of current and previous buffers, and update fyler if root changes
local previous_buffer_root = ""

vim.api.nvim_create_autocmd("BufLeave", {
  desc = "Store root of buffer being left",
  callback = function(args)
    previous_buffer_root = require("lazyvim.util.root").get({ buf = args.buf })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Update fyler tree when root changes between buffers",
  callback = function(args)
    local current_buffer_root = require("lazyvim.util.root").get({ buf = args.buf })
    local current_buf_name = vim.api.nvim_buf_get_name(args.buf)
    local current_buf_ft = vim.bo[args.buf].filetype

    -- Update fyler tree if root has changed and we're entering a regular file
    if previous_buffer_root ~= current_buffer_root and current_buffer_root ~= "" then
      -- Skip for special buffers like fyler, help, etc.
      local skip_update = vim.startswith(current_buf_name, "fyler://") or
         current_buf_ft == "help" or
         current_buf_ft == "lazy" or
         current_buf_name == "" or
         vim.startswith(current_buf_name, "term://")

      if not skip_update then
        local finder_module = require("fyler.views.finder")
        -- Only update if fyler is currently active
        if finder_module._current then
          finder_module._current:chdir(current_buffer_root)
          finder_module._current:dispatch_refresh(function()
            require("fyler").navigate(current_buf_name)
          end)
        end
      end
    end

    -- Update previous buffer root for next comparison
    previous_buffer_root = current_buffer_root
  end,
})
