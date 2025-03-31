return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      -- virtual_text = {
      --   prefix = "■",
      -- },
    },
    servers = {
      cssls = {},
      cssmodules_ls = {},
      emmet_language_server = {},
      html = {},
    },
  },
}
