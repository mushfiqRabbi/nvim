local workarounds_needed = false

if not workarounds_needed then
  return {}
end

return {
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
