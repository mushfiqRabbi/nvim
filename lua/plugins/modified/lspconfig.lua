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
        tailwindcss = {
          filetypes_exclude = {
            "aspnetcorerazor",
            "astro",
            "astro-markdown",
            "blade",
            "clojure",
            "django-html",
            "htmldjango",
            "edge",
            "eelixir",
            "elixir",
            "ejs",
            "erb",
            "eruby",
            "gohtml",
            "gohtmltmpl",
            "haml",
            "handlebars",
            "hbs",
            "htmlangular",
            "html-eex",
            "heex",
            "jade",
            "leaf",
            "liquid",
            "markdown",
            "mdx",
            "mustache",
            "njk",
            "nunjucks",
            "php",
            "razor",
            "slim",
            "twig",
            "stylus",
            "sugarss",
            "javascript",
            "reason",
            "rescript",
            "typescript",
            "vue",
            "svelte",
            "templ",
          },
        },
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
