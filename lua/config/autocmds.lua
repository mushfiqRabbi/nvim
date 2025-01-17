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

-- NOTE: shade and tint from https://maketintsandshades.com/#3b4261
vim.api.nvim_set_hl(0, "IndentDark", { fg = "#292e44" }) -- 30% shade
vim.api.nvim_set_hl(0, "IndentLight", { fg = "#4f5571" }) -- 10% tint
-- NOTE: shade and tint from https://maketintsandshades.com/#292e42
vim.cmd("hi MatchParen guibg=#545868") -- 20% tint
