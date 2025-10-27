return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
        -- virtual_text = {
        --   severity = {
        --     max = vim.diagnostic.severity.INFO,
        --   },
        --   -- prefix = "■",
        -- },
        float = {
          border = "solid",
        },
      },
      servers = {
        cssls = {},
        cssmodules_ls = {
          filetypes = { "javascriptreact", "typescriptreact" },
        },
        emmet_language_server = {},
        html = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Kemaps
        ["*"] = {
          keys = {
            { "<leader>cl", false },
          },
        },
      },
    },
  },
}
