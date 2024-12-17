return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = {
        prefix = "■",
      },
    },
    servers = {
      cssls = {},
      cssmodules_ls = {},
      emmet_language_server = {
        filetypes = {
          "css",
          "eruby",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "php",
          "sass",
          "scss",
          "pug",
          "typescript",
          "typescriptreact",
        },
      },
      html = {},
      prismals = {},
    },
  },
}
