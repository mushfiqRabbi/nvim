local workarounds_needed = false

if not workarounds_needed then
  return {}
end

vim.notify("workarounds.lua is running", vim.log.levels.WARN, { timeout = 5000 })
return {
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
