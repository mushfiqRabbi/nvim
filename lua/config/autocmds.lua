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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh", -- Trigger for sh filetype
  callback = function(args)
    -- Get the file name
    local filename = vim.api.nvim_buf_get_name(args.buf)

    -- Check if the file is any type of .env file
    if string.match(filename, "%.env.*") then
      -- Delay the check to ensure the LSP client has time to attach
      vim.defer_fn(function()
        -- Get all active LSP clients for the current buffer
        local clients = vim.lsp.get_clients({ bufnr = args.buf })

        -- Iterate through the clients and stop bashls if it's attached
        for _, client in ipairs(clients) do
          if client.name == "bashls" then
            client.stop(client, true) -- Forcefully stop the client
          end
        end
      end, 500) -- Delay of 500ms
    end
  end,
})
