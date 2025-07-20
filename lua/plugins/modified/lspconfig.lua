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
        cssmodules_ls = {},
        emmet_language_server = {},
        html = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "<leader>cl",
        false,
      }
    end,
  },
}
