return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = {
        severity = {
          max = vim.diagnostic.severity.INFO,
        },
        -- prefix = "■",
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
