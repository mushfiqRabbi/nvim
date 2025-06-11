-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Autocommands

-- vim.api.nvim_create_autocmd("User", { -- Creates an autocommand for the User event
--   pattern = "TelescopePreviewerLoaded", -- The event pattern to trigger on
--   callback = function(args) -- Callback function to execute
--     if args.data.filetype ~= "help" then -- If the filetype is not help
--       vim.wo.number = true -- Enable line numbers
--     elseif args.data.bufname:match("*.csv") then -- If the buffer name matches a CSV file
--       vim.wo.wrap = false -- Disable line wrapping
--     end
--   end,
-- })

-- Usercommands
-- Define a user command called 'GenerateDotIgnore'
vim.api.nvim_create_user_command("GenerateDotIgnore", function() -- Creates a user command
  local root = require("lazyvim.util").root() -- Gets the project root directory
  vim.cmd( -- Executes a Vim command
    "call writefile(['.git/', '.vscode/', '!.env', '!.env.*', '!.env.*.local', '!.stylelintrc.json'], '" -- Calls the writefile function to create a .ignore file with specified patterns
      .. root -- Adds the project root to the path
      .. "/.ignore" -- Specifies the .ignore file path
      .. "')" -- Closes the string
  )
  print("Created .ignore file in " .. root) -- Prints a message to the console
end, {}) -- Options for the command

-- Define a user command called 'GenerateDotSpell'
vim.api.nvim_create_user_command("GenerateDotSpell", function() -- Creates a user command
  local root = require("lazyvim.util").root() -- Gets the project root directory
  vim.cmd("call writefile([], '" .. require("lazyvim.util").root() .. "/.cspell" .. "')") -- Creates an empty .cspell file
  vim.cmd("call writefile([], '" .. require("lazyvim.util").root() .. "/.codespell" .. "')") -- Creates an empty .codespell file
  print("Created .cspell and .codespell file in " .. root) -- Prints a message to the console
end, {}) -- Options for the command

-- Define a user command called 'GenerateDotNoCSpell'
vim.api.nvim_create_user_command("GenerateDotNoCSpell", function() -- Creates a user command
  local root = require("lazyvim.util").root() -- Gets the project root directory
  vim.cmd("call writefile([], '" .. require("lazyvim.util").root() .. "/.nocspell" .. "')") -- Creates an empty .nocspell file
  print("Created .nocspell file in " .. root) -- Prints a message to the console
end, {}) -- Options for the command

-- Restore cursor to Beam on leave.
-- vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, { -- Creates an autocommand for VimLeave and VimSuspend events
--   pattern = { "*" }, -- Trigger on all files
--   callback = function() -- Callback function to execute
--     vim.o.guicursor = "a:ver100" -- Restore the cursor style
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter" }, { -- Creates an autocommand for the BufEnter event
--   pattern = { "*" }, -- Trigger on all files
--   callback = function() -- Callback function to execute
--     if vim.bo.filetype == "snacks_notif" then -- If the filetype is snacks_notif
--       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w><C-w>", true, false, true), "n", false) -- Send keys to navigate windows
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", { -- Creates an autocommand for the FileType event
--   pattern = "sh", -- Trigger for sh filetype
--   callback = function(args) -- Callback function to execute
--     -- Get the file name
--     local filename = vim.api.nvim_buf_get_name(args.buf) -- Get the buffer name
--
--     -- Check if the file is any type of .env file
--     if string.match(filename, "%.env.*") then -- If the filename matches .env.*
--       -- Delay the check to ensure the LSP client has time to attach
--       vim.defer_fn(function() -- Defer the execution of the function
--         -- Get all active LSP clients for the current buffer
--         local clients = vim.lsp.get_clients({ bufnr = args.buf }) -- Get LSP clients attached to the buffer
--
--         -- Iterate through the clients and stop bashls if it's attached
--         for _, client in ipairs(clients) do -- Iterate through the clients
--           if client.name == "bashls" then -- If the client is bashls
--             client.stop(client, true) -- Forcefully stop the client
--           end
--         end
--       end, 500) -- Delay of 500ms
--     end
--   end,
-- })

-- Autocommand to handle LSP attach events
vim.api.nvim_create_autocmd("LspAttach", { -- Creates an autocommand for the LspAttach event
  callback = function(args) -- Callback function to execute
    local filename = vim.api.nvim_buf_get_name(args.buf) -- Get the filename of the buffer
    if string.match(filename, "%.env.*") then -- Check if the filename matches the pattern of an environment file
      local client = vim.lsp.get_client_by_id(args.data.client_id) -- Get the LSP client by its ID
      if client then -- If a client is found
        if client.name == "bashls" then -- Check if the client's name is "bashls"
          client.stop(client, true) -- Forcefully stop the bashls client
        end
      end
    end
  end,
})

-- -- NOTE: Diagnostic floating window when the cursor is on the current line
-- -- This section is commented out and not currently active
--
-- vim.api.nvim_create_augroup("LspDiagnosticsFloat", { clear = true }) -- Creates an autogroup for LSP diagnostics float with clear option
--
-- vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, { -- Creates an autocommand for CursorHold and InsertLeave events
--   group = "LspDiagnosticsFloat", -- Assigns the autocommand to the LspDiagnosticsFloat autogroup
--   callback = function() -- Callback function to execute
--     local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Gets the cursor position in the current window
--     local line = cursor_pos[1] - 1 -- Convert to 0-based index
--     local bufnr = vim.api.nvim_get_current_buf() -- Gets the current buffer number
--     local diagnostics = vim.diagnostic.get(bufnr, { lnum = line }) -- Gets diagnostics for the current buffer and line
--
--     if #diagnostics > 0 then -- If there are diagnostics
--       vim.diagnostic.open_float(nil, { -- Opens a floating window to display diagnostics
--         focusable = false, -- Makes the window not focusable
--         scope = "line", -- Use "line" instead of "cursor" to show diagnostics for the whole line
--         close_events = { "BufLeave", "CursorMoved", "InsertEnter" }, -- Defines events to close the window
--         border = "solid", -- Sets a solid border for the window
--       })
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "BufEnter" }, { -- Creates an autocommand for the BufEnter event
--   pattern = { "tmux.conf", "tmux.conf.local", ".tmux.conf" }, -- Patterns to match tmux configuration files
--   callback = function() -- Callback function to execute
--     vim.lsp.start({ -- Starts an LSP client
--       name = "tmux", -- Sets the name of the LSP client to "tmux"
--       cmd = { "tmux-language-server" }, -- Command to start the tmux language server
--     })
--   end,
-- })

-- Auto stop LSP when no buffers are attached to the client
-- vim.api.nvim_create_autocmd("LspDetach", { -- Creates an autocommand for the LspDetach event
--
--   group = vim.api.nvim_create_augroup("nuance-lsp-detach", { clear = true }), -- Creates an autogroup for nuance-lsp-detach with clear option
--
--   callback = function(event) -- Callback function to execute
--     vim.lsp.buf.clear_references() -- Clears LSP references for the buffer
--
--     vim.api.nvim_clear_autocmds({ group = "nuance-lsp-detach", buffer = event.buf }) -- Clears autocommands for the buffer in the nuance-lsp-detach autogroup
--
--     vim.defer_fn(function() -- Defer the execution of the function
--       -- Kill the LS process if no buffers are attached to the client
--
--       local cur_client = vim.lsp.get_client_by_id(event.data.client_id) -- Gets the LSP client by its ID
--
--       if cur_client == nil then -- If the current client is nil
--         return -- Exit the function
--       end
--
--       local attached_buffers_count = vim.tbl_count(cur_client.attached_buffers) -- Counts the number of attached buffers to the client
--
--       if attached_buffers_count == 0 then -- If there are no attached buffers
--         vim.notify( -- Sends a notification
--           "***" .. cur_client.name .. "***: No buffers. Stopping server.", -- Notification message with the client's name
--           vim.log.levels.INFO, -- Sets the log level to INFO
--           { title = "LSP" } -- Sets the title of the notification to "LSP"
--         )
--
--         ---@diagnostic disable-next-line: param-type-mismatch
--         cur_client.stop(true) -- Stops the client
--       end
--     end, 200) -- Delay of 200ms
--   end,
-- })

-- Initialize an empty table to store LSP detach timers
local lsp_detach = {} -- Table to store LSP detach timers
-- Get the vim.uv module for timer functions
local uv = vim.uv -- Access libuv functionality

-- Define a function to stop an LSP client after a timeout
local stop_client_timeout = function(client_id, timer) -- Function to stop LSP client after timeout
  timer:start( -- Start the timer
    1000 * 60, -- 60 seconds timeout
    0, -- No repeat
    vim.schedule_wrap(function() -- Schedule the function to run in the main thread
      timer:stop() -- Stop the timer
      if -- Check if the LSP client is still running and has no attached buffers
        not vim.lsp.client_is_stopped(client_id) -- If client is not stopped
        and #(vim.lsp.get_buffers_by_client_id(client_id)) == 0 -- and no buffers attached
      then
        vim.notify( -- Send a notification
          "***" .. (vim.lsp.get_client_by_id(client_id)).name .. "***" .. ": Stopping lsp client", -- Message to display
          vim.log.levels.INFO, -- Log level
          { title = "LSP Auto Stop" } -- Notification title
        )
        vim.lsp.stop_client(client_id, true) -- Stop the LSP client
      end
      timer:close() -- Close the timer
      lsp_detach[client_id] = nil -- Remove the timer from the table
    end)
  )
end

-- Autocommand to handle LSP detach events
vim.api.nvim_create_autocmd("LspDetach", { -- Creates an autocommand for the LspDetach event
  group = vim.api.nvim_create_augroup("lsp-auto-stop", { clear = true }), -- Creates an autogroup for lsp-auto-stop with clear option
  callback = function(args) -- Callback function to execute
    if not args.data.client_id then -- If there is no client ID
      return -- Exit the function
    else
      if not lsp_detach[args.data.client_id] then -- If there is no timer for this client ID
        lsp_detach[args.data.client_id] = { timer = uv.new_timer() } -- Create a new timer
      else
        lsp_detach[args.data.client_id].timer:stop() -- Stop the existing timer
      end
      stop_client_timeout(args.data.client_id, lsp_detach[args.data.client_id].timer) -- Start the timeout to stop the LSP client
    end
  end,
})

-- Autocommand to set Kitty terminal variable on BufEnter
vim.api.nvim_create_autocmd("BufEnter", { -- Creates an autocommand for the BufEnter event
  group = vim.api.nvim_create_augroup("KittySetVarBufRead", { clear = true }), -- Creates an autogroup for KittySetVarBufRead with clear option
  callback = function(args) -- Callback function to execute
    local filepath = vim.fn.fnamemodify(args.file, ":p") -- Get the full file path
    local encoded = vim.fn.system("printf %s " .. vim.fn.shellescape(filepath) .. " | base64") -- Encode the filepath to base64
    encoded = encoded:gsub("%s+", "") -- Trim any trailing whitespace or newline

    io.stdout:write("\x1b]1337;SetUserVar=current_file=" .. encoded .. "\007") -- Write the encoded filepath to Kitty terminal
  end,
})

-- Autocommand to unset Kitty terminal variable on VimLeave
vim.api.nvim_create_autocmd("VimLeave", { -- Creates an autocommand for the VimLeave event
  group = vim.api.nvim_create_augroup("KittyUnsetVarOnExit", { clear = true }), -- Creates an autogroup for KittyUnsetVarOnExit with clear option
  callback = function() -- Callback function to execute
    io.stdout:write("\x1b]1337;SetUserVar=current_file\007") -- Unset the Kitty terminal variable
  end,
})
