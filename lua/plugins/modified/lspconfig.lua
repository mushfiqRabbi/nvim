return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = {
        prefix = "🭰",
        suffix = "🭵",
        severity = {
          max = vim.diagnostic.severity.INFO,
        },
      },
      float = {
        border = "solid",
      },
    },
    servers = {
      cssls = {},
      cssmodules_ls = {},
      emmet_language_server = {},
      html = {},
    },
  },
}
