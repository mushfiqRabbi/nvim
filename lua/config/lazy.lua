-- ============================================================================
-- LAZY.NVIM BOOTSTRAP
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({
    "git", "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- ============================================================================
-- LAZY.NVIM SETUP
-- ============================================================================

require("lazy").setup({
  -- ==========================================================================
  -- PLUGIN SPECIFICATIONS
  -- ==========================================================================

  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- import any extras modules here

    -- ========================================================================
    -- CODING ENHANCEMENTS
    -- ========================================================================
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- ========================================================================
    -- EDITOR FEATURES
    -- ========================================================================
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.dial" },
    { import = "lazyvim.plugins.extras.editor.inc-rename" },
    { import = "lazyvim.plugins.extras.editor.mini-diff" },

    -- ========================================================================
    -- CODE FORMATTING
    -- ========================================================================
    { import = "lazyvim.plugins.extras.formatting.prettier" },

    -- ========================================================================
    -- LANGUAGE SUPPORT
    -- ========================================================================
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.prisma" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.yaml" },

    -- ========================================================================
    -- CODE LINTING
    -- ========================================================================
    { import = "lazyvim.plugins.extras.linting.eslint" },

    -- ========================================================================
    -- USER INTERFACE
    -- ========================================================================
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },

    -- ========================================================================
    -- UTILITIES
    -- ========================================================================
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.util.dot" },

    -- ========================================================================
    -- VSCODE INTEGRATION
    -- ========================================================================
    { import = "lazyvim.plugins.extras.vscode" },

    -- ========================================================================
    -- CUSTOM PLUGINS
    -- ========================================================================
    { import = "plugins.modified" },
    { import = "plugins.added" },
    { import = "plugins" },
  },

  -- ==========================================================================
  -- DEFAULT PLUGIN SETTINGS
  -- ==========================================================================

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },

  -- ==========================================================================
  -- INSTALLATION SETTINGS
  -- ==========================================================================

  install = { colorscheme = { "tokyonight", "habamax" } },
  -- ui = {
  --   border = "single",
  -- },
  checker = { enabled = true }, -- automatically check for plugin updates

  -- ==========================================================================
  -- PERFORMANCE OPTIMIZATION
  -- ==========================================================================

  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  -- ==========================================================================
  -- ROCKS CONFIGURATION
  -- ==========================================================================

  rocks = {
    hererocks = true,
  },
})
