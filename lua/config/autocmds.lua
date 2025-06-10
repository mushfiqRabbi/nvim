-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Autocommands

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "TelescopePreviewerLoaded",
--   callback = function(args)
--     if args.data.filetype ~= "help" then
--       vim.wo.number = true
--     elseif args.data.bufname:match("*.csv") then
--       vim.wo.wrap = false
--     end
--   end,
-- })

-- Usercommands
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

-- Restore cursor to Beam on leave.
-- vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.o.guicursor = "a:ver100"
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "*" },
--   callback = function()
--     if vim.bo.filetype == "snacks_notif" then
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w><C-w>", true, false, true), "n", false)
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "sh", -- Trigger for sh filetype
--   callback = function(args)
--     -- Get the file name
--     local filename = vim.api.nvim_buf_get_name(args.buf)
--
--     -- Check if the file is any type of .env file
--     if string.match(filename, "%.env.*") then
--       -- Delay the check to ensure the LSP client has time to attach
--       vim.defer_fn(function()
--         -- Get all active LSP clients for the current buffer
--         local clients = vim.lsp.get_clients({ bufnr = args.buf })
--
--         -- Iterate through the clients and stop bashls if it's attached
--         for _, client in ipairs(clients) do
--           if client.name == "bashls" then
--             client.stop(client, true) -- Forcefully stop the client
--           end
--         end
--       end, 500) -- Delay of 500ms
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local filename = vim.api.nvim_buf_get_name(args.buf)
    if string.match(filename, "%.env.*") then
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        if client.name == "bashls" then
          client.stop(client, true) -- Forcefully stop the client
        end
      end
    end
  end,
})

-- -- NOTE: Diagnostic floating window when the cursor is on the current line
--
-- vim.api.nvim_create_augroup("LspDiagnosticsFloat", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
--   group = "LspDiagnosticsFloat",
--   callback = function()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     local line = cursor_pos[1] - 1 -- Convert to 0-based index
--     local bufnr = vim.api.nvim_get_current_buf()
--     local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
--
--     if #diagnostics > 0 then
--       vim.diagnostic.open_float(nil, {
--         focusable = false,
--         scope = "line", -- Use "line" instead of "cursor" to show diagnostics for the whole line
--         close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
--         border = "solid",
--       })
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = { "tmux.conf", "tmux.conf.local", ".tmux.conf" },
--   callback = function()
--     vim.lsp.start({
--       name = "tmux",
--       cmd = { "tmux-language-server" },
--     })
--   end,
-- })

-- Auto stop LSP when no buffers are attached to the client
-- vim.api.nvim_create_autocmd("LspDetach", {
--
--   group = vim.api.nvim_create_augroup("nuance-lsp-detach", { clear = true }),
--
--   callback = function(event)
--     vim.lsp.buf.clear_references()
--
--     vim.api.nvim_clear_autocmds({ group = "nuance-lsp-detach", buffer = event.buf })
--
--     vim.defer_fn(function()
--       -- Kill the LS process if no buffers are attached to the client
--
--       local cur_client = vim.lsp.get_client_by_id(event.data.client_id)
--
--       if cur_client == nil then
--         return
--       end
--
--       local attached_buffers_count = vim.tbl_count(cur_client.attached_buffers)
--
--       if attached_buffers_count == 0 then
--         vim.notify(
--           "***" .. cur_client.name .. "***: No buffers. Stopping server.",
--           vim.log.levels.INFO,
--           { title = "LSP" }
--         )
--
--         ---@diagnostic disable-next-line: param-type-mismatch
--         cur_client.stop(true)
--       end
--     end, 200)
--   end,
-- })

local lsp_detach = {}
local uv = vim.uv

local stop_client_timeout = function(client_id, timer)
  timer:start(
    1000 * 60,
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
    else
      if not lsp_detach[args.data.client_id] then
        lsp_detach[args.data.client_id] = { timer = uv.new_timer() }
      else
        lsp_detach[args.data.client_id].timer:stop()
      end
      stop_client_timeout(args.data.client_id, lsp_detach[args.data.client_id].timer)
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("KittySetVarBufRead", { clear = true }),
  callback = function(args)
    local filepath = vim.fn.fnamemodify(args.file, ":p")
    local encoded = vim.fn.system("printf %s " .. vim.fn.shellescape(filepath) .. " | base64")
    encoded = encoded:gsub("%s+", "") -- Trim any trailing whitespace or newline

    io.stdout:write("\x1b]1337;SetUserVar=current_file=" .. encoded .. "\007")
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = vim.api.nvim_create_augroup("KittyUnsetVarOnExit", { clear = true }),
  callback = function()
    io.stdout:write("\x1b]1337;SetUserVar=current_file\007")
  end,
})
