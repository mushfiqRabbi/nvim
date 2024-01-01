--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- local auto_diag_float
vim.g["python3_host_prog"] = "~/.pyenv/versions/py3nvim/bin/python"
vim.g["node_host_prog"] = "~/.nvm/versions/node/v16.20.2/bin/neovim-node-host"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- vim.g['rooter_cd_cmd'] = 'lcd'
vim.opt.scrolloff = 7
vim.o.cursorline = true
vim.opt.colorcolumn = "80"

vim.g["rooter_change_directory_for_non_project_files"] = "current"

-- vim.cmd [[
--   let g:VM_maps = {}
--   let g:VM_maps["Exit"]               = '<C-C>'   " quit VM
--   let g:VM_maps['Find Under']         = ''   " replace C-n
--   let g:VM_maps['Find Subword Under'] = ''   " replace visual C-n
-- ]]

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }
-- vim.cmd([[
--   set guicursor+=a:blinkon1
-- ]])
-- vim.o.shell = 'C:\\"Program Files"\\PowerShell\\7\\pwsh.exe'
-- vim.o.shell = '/usr/bin/zsh'
-- vim.o.shellcmdflag = '-command'
-- vim.o.shellquote = '"'
-- vim.o.shellxquote = ''

-- vim.cmd [[
-- set shell=pwsh.exe
-- set shellcmdflag=-command
-- set shellquote=\"
-- set shellxquote=
-- ]]

vim.keymap.set("n", "<C-s>", "<cmd>update<CR>", { noremap = true, silent = true })
-- vim.keymap.set('v', '<C-s>', '<C-c><cmd>update<CR>', { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<cmd>update<CR>", { noremap = true, silent = true })
-- vim.keymap.set({ 'n', 'i' }, '<C-s>', '<cmd>w<CR>', { noremap = true })

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- vim.cmd [[
--     let g:VM_maps = {}
--     let g:VM_maps['Find Under'] = '<leader>m'
--     let g:VM_maps['Find Subword Under'] = '<leader>m'
--     let g:VM_mouse_mappings = 1
--     ]]

vim.filetype.add({
  -- Detect and assign filetype based on the extension of the filename
  --   extension = {
  --     log = "log",
  --     conf = "conf",
  --     env = "dotenv",
  --   },
  -- Detect and apply filetypes based on the entire filename
  -- filename = {
  --   [".env"] = "dotenv",
  --   ["env"] = "dotenv",
  -- },
  -- Detect and apply filetypes based on certain patterns of the filenames
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.?env[%.%w_.-]*"] = "sh",
  },
})

-- vim.cmd [[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePost * FormatWrite
-- augroup END
-- ]]

-- vim.cmd [[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd User FormatterPre lua print "Formatting..."
--   autocmd User FormatterPost lua print "Format complete."
-- augroup END
--   ]]

vim.keymap.set("i", "<C-w>", "<C-c><C-w>", { noremap = true })

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("lazy").setup({

  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        "j-hui/fidget.nvim",
        opts = {
          progress = {
            display = {
              done_icon = "",
              progress_icon = { pattern = "dots_pulse", period = 0.5 },
            },
            ignore = {
              "null-ls",
            },
          },
          notification = {
            window = {
              -- winblend = 75,
              x_padding = 2,
            },
          },
        },
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- 'f3fora/cmp-spell',
      "hrsh7th/cmp-cmdline",
      -- 'dmitmel/cmp-cmdline-history',
      -- 'hrsh7th/cmp-calc',
      -- 'hrsh7th/cmp-emoji',
      -- 'chrisgrieser/cmp_yanky',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      -- on_attach = function(bufnr)
      -- vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

      -- don't override the built-in and fugitive keymaps
      -- local gs = package.loaded.gitsigns
      -- vim.keymap.set({ 'n', 'v' }, ']c', function()
      --   if vim.wo.diff then
      --     return ']c'
      --   end
      --   vim.schedule(function()
      --     gs.next_hunk()
      --   end)
      --   return '<Ignore>'
      -- end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
      -- vim.keymap.set({ 'n', 'v' }, '[c', function()
      --   if vim.wo.diff then
      --     return '[c'
      --   end
      --   vim.schedule(function()
      --     gs.prev_hunk()
      --   end)
      --   return '<Ignore>'
      -- end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      -- end,
    },
  },

  {
    -- -- Theme inspired by Atom
    -- 'navarasu/onedark.nvim',
    -- priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },

  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          -- component_separators = "│",
          -- section_separators = "",

          -- theme = 'onedark',
          -- theme = 'tokyonight',
          theme = "catppuccin-mocha",
        },
        sections = {
          lualine_x = {
            -- {
            --   function()
            --     return vim.fn['codeium#GetStatusString']()
            --   end,
            -- },

            {
              function()
                if string.find(require("noice").api.statusline.mode.get(), "recording") then
                  return require("noice").api.statusline.mode.get()
                else
                  return ""
                end
              end,
              -- require('noice').api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            },
            "encoding",
            "fileformat",
            "filetype",
          },
        },
      })
    end,
  },
  -- '▏'
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
      },
      scope = {
        show_start = false,
        show_end = false,
        -- include = {
        --   node_type = { ['*'] = { '*' } },
        -- },
      },
    },
    -- config = function()
    -- local highlight = {
    --   'RainbowRed',
    --   'RainbowYellow',
    --   'RainbowBlue',
    --   'RainbowOrange',
    --   'RainbowGreen',
    --   'RainbowViolet',
    --   'RainbowCyan',
    -- }
    --
    -- local hooks = require 'ibl.hooks'
    -- -- create the highlight groups in the highlight setup hook, so they are reset
    -- -- every time the colorscheme changes
    -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --   vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
    --   vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
    --   vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
    --   vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
    --   vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
    --   vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
    --   vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
    -- end)
    -- --
    -- vim.g.rainbow_delimiters = { highlight = highlight }

    -- require('ibl').setup {
    --
    --   indent = {
    --     char = '▏',
    --   },
    --   scope = {
    --     -- highlight = highlight,
    --     show_start = false,
    --     show_end = false,
    --     -- include = {
    --     --   node_type = { ['*'] = { '*' } },
    --     -- },
    --   },
    -- }

    -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    -- end,
  },

  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    --opts = {
    --  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    --},
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- commit = 'cf847b587ac058cf2edcc2131daaef4ae9e8bf18',
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = "custom.plugins" },
}, {
  ui = {
    size = { width = 0.7, height = 0.85 },
    border = "single",
    title = " LAZY ",
  },
})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Make relative line numbers default
vim.wo.rnu = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<CR>", "<Nop>", { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<CR>', ':', { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<backspace>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-v>", "<Nop>", { silent = true })
-- vim.keymap.set({ 'n', 'v', 'i' }, '<C-t>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
--
-- local layout_config = {}
--
--
-- if vim.fn.hostname() == 'DESKTOP-QP9KQE3' then
--   layout_config = {
--     height = 0.9,
--     width = 0.7,
--     preview_width = 0.65,
--   }
-- elseif vim.fn.hostname() == 'DESKTOP-CKMOCDG' then
--   layout_config = {
--     height = 0.95,
--     width = 0.8,
--     preview_width = 0.6,
--   }
-- end

-- local previewers = require 'telescope.previewers'
-- local Job = require 'plenary.job'
-- local new_maker = function(filepath, bufnr, opts)
--   filepath = vim.fn.expand(filepath)
--   Job:new({
--     command = 'file',
--     args = { '--mime-type', '-b', filepath },
--     on_exit = function(j)
--       -- local mime_type = vim.split(j:result()[1], '/')[1]
--       local is_preview = false
--       if string.match(j:result()[1], 'text') then
--         is_preview = true
--       elseif string.match(j:result()[1], 'json') then
--         is_preview = true
--       elseif string.match(j:result()[1], 'jpg') then
--         is_preview = true
--       elseif string.match(j:result()[1], 'jpeg') then
--         is_preview = true
--       elseif string.match(j:result()[1], 'png') then
--         is_preview = true
--       end
--       if is_preview then
--         previewers.buffer_previewer_maker(filepath, bufnr, opts)
--       else
--         -- maybe we want to write something to the buffer here
--         vim.schedule(function()
--           vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
--         end)
--       end
--     end,
--   }):sync()
-- end

-- require('telescope').setup {
--   defaults = {
--     buffer_previewer_maker = new_maker,
--   },
-- }

local trouble = require("trouble.providers.telescope")

-- local actions = require 'telescope.actions'
--

-- local is_image = function(filepath)
--   local image_extensions = { 'png', 'jpg', 'jpeg' } -- Supported image formats
--   local split_path = vim.split(filepath:lower(), '.', { plain = true })
--   local extension = split_path[#split_path]
--   return vim.tbl_contains(image_extensions, extension)
-- end

require("telescope").setup({
  defaults = {
    -- winblend = 7,
    wrap_results = true,
    skip_empty_lines = true,
    dynamic_preview_title = true,
    sorting_strategy = "ascending",
    preview = {
      filesize_limit = 0.1, -- MB
    },
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "┌",
      "┐",
      "┘",
      "└",
    },
    -- borderchars = {
    --   "─",
    --   "│",
    --   "─",
    --   "│",
    --   "┌ ",
    --   "┐",
    --   "┘",
    --   "└",
    -- },
    -- preview = {
    --   mime_hook = function(filepath, bufnr, opts)
    --     if is_image(filepath) then
    --       local term = vim.api.nvim_open_term(bufnr, {})
    --       local function send_output(_, data, _)
    --         for _, d in ipairs(data) do
    --           vim.api.nvim_chan_send(term, d .. '\r\n')
    --         end
    --       end
    --       vim.fn.jobstart({
    --         'catimg',
    --         filepath, -- Terminal image viewer command
    --       }, { on_stdout = send_output, stdout_buffered = true, pty = true })
    --     else
    --       require('telescope.previewers.utils').set_preview_message(bufnr, opts.winid, 'Binary cannot be previewed')
    --     end
    --   end,
    -- },
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.8,
      height = 0.95,
      preview_width = 0.65,
      prompt_position = "top",
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim", -- add this value
    },
    mappings = {
      n = {
        -- ['<C-q>'] = false,
        ["<C-q>"] = trouble.open_selected_with_trouble,
        -- ['<C-c>'] = require('telescope.actions').close,
        ["<C-g>"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          if not selection.path and not selection.value then
            return
          elseif not selection.path and not selection.filename then
            require("telescope.actions").close(prompt_bufnr)
            require("nvim-tree.api").tree.open({ path = selection.value })
            require("nvim-tree.api").node.navigate.parent()
          else
            local root_dir = vim.fn.FindRootDirectory(selection.path)
            if root_dir == "" then
              root_dir = vim.fn.fnamemodify(selection.path, ":h")
            end
            require("telescope.actions").close(prompt_bufnr)
            require("nvim-tree.api").tree.open({ path = root_dir })
            require("nvim-tree.api").tree.find_file({
              buf = selection.path,
            })
          end
          -- require("telescope.actions").close(prompt_bufnr)
          -- Depending on what you want put `cd`, `lcd`, `tcd`
          -- vim.cmd(string.format("Oil %s", dir))
          -- require("nvim-tree.api").tree.open({ path = dir })
          -- vim.cmd(string.format('lua MiniFiles.open(%s)', dir))
          -- MiniFiles.open(dir, false)
        end,
        -- ['cd'] = function(prompt_bufnr)
        --   local selection = require('telescope.actions.state').get_selected_entry()
        --   local dir
        --   if not selection.path then
        --     dir = selection.value
        --   else
        --     dir = vim.fn.fnamemodify(selection.path, ':p:h')
        --   end
        --   require('telescope.actions').close(prompt_bufnr)
        --   -- Depending on what you want put `cd`, `lcd`, `tcd`
        --   vim.cmd(string.format('silent lcd %s', dir))
        -- end,
        ["<C-\\>"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          local path
          if not selection.path and not selection.value then
            return
          elseif not selection.path and not selection.filename then
            path = selection.value
          else
            path = selection.path
          end
          -- print(path)
          -- print(vim.fn.FindRootDirectory(path))
          local dir = vim.fn.FindRootDirectory(path)
          if dir == "" then
            dir = vim.fn.fnamemodify(path, ":h")
          end
          require("telescope.actions").close(prompt_bufnr)
          vim.cmd(string.format("ToggleTerm dir=%s", dir))
        end,
      },
      i = {
        -- ['<C-q>'] = false,
        ["<C-q>"] = trouble.open_selected_with_trouble,
        -- ['<C-u>'] = false,
        -- ['<C-d>'] = false,
        ["<C-g>"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          if not selection.path and not selection.value then
            return
          elseif not selection.path and not selection.filename then
            require("telescope.actions").close(prompt_bufnr)
            require("nvim-tree.api").tree.open({ path = selection.value })
            require("nvim-tree.api").node.navigate.parent()
          else
            local root_dir = vim.fn.FindRootDirectory(selection.path)
            if root_dir == "" then
              root_dir = vim.fn.fnamemodify(selection.path, ":h")
            end
            require("telescope.actions").close(prompt_bufnr)
            require("nvim-tree.api").tree.open({ path = root_dir })
            require("nvim-tree.api").tree.find_file({
              buf = selection.path,
            })
          end
          -- require("telescope.actions").close(prompt_bufnr)
          -- Depending on what you want put `cd`, `lcd`, `tcd`
          -- vim.cmd(string.format("Oil %s", dir))
          -- require("nvim-tree.api").tree.open({ path = dir })
          -- MiniFiles.open(dir, false)
        end,
        -- ['<C-w>'] = function(prompt_bufnr)
        --   local selection = require('telescope.actions.state').get_selected_entry()
        --   local dir = vim.fn.fnamemodify(selection.path, ':p:h')
        --   require('telescope.actions').close(prompt_bufnr)
        --   -- Depending on what you want put `cd`, `lcd`, `tcd`
        --   vim.cmd(string.format('silent lcd %s', dir))
        -- end,
        ["<C-\\>"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          local path
          if not selection.path and not selection.value then
            return
          elseif not selection.path and not selection.filename then
            path = selection.value
          else
            path = selection.path
          end
          -- print(path)
          -- print(vim.fn.FindRootDirectory(path))
          local dir = vim.fn.FindRootDirectory(path)
          if dir == "" then
            dir = vim.fn.fnamemodify(path, ":h")
          end
          require("telescope.actions").close(prompt_bufnr)
          vim.cmd(string.format("ToggleTerm dir=%s", dir))
          vim.cmd.normal("i")
        end,
      },
    },
  },
  pickers = {
    find_files = {
      -- wrap_results = true,
      find_command = {
        "rg",
        "--files",
        "--follow",
        "--hidden",
        "-g",
        "!.git",
        "-g",
        "!.vscode",
        --   -- 'rg',
        --   -- '--files',
        --   -- '--hidden',
        --   -- '--follow',
        --   -- '--glob',
        --   -- '!.git',
        --   -- '--glob',
        --   -- '!.vscode',
        --   -- 'fd',
        --   -- '--type',
        --   -- 'f',
        --   -- '--hidden',
        --   -- '--follow',
        --   -- '--absolute-path',
        --   -- '--exclude',
        --   -- '.git',
        --   -- '--exclude',
        --   -- '.vscode',
      },
    },
    -- oldfiles = {
    --   -- wrap_results = true,
    -- },
    -- buffers = {
    --   -- wrap_results = true,
    -- },
    -- git_files = {
    --   -- wrap_results = true,
    -- },
    -- current_buffer_fuzzy_find = {
    --   -- wrap_results = true,
    --   -- skip_empty_lines = true,
    -- },
    -- help_tags = {
    --   -- wrap_results = true,
    -- },
    -- grep_string = {
    --   -- wrap_results = true,
    -- },
    -- live_grep = {
    --   -- wrap_results = true,
    -- },
    -- diagnostics = {
    --   -- wrap_results = true,
    -- },
  },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "yank_history")
pcall(require("telescope").load_extension, "projects")
-- pcall(require('telescope').load_extension, 'ascii')
pcall(require("telescope").load_extension("undo"))
-- pcall(require('telescope').load_extension 'neoclip')
pcall(require("telescope").load_extension("harpoon"))

-- See `:help telescope.builtin`
vim.keymap.set(
  "n",
  "<leader>fo",
  "<cmd>lua require('telescope.builtin').oldfiles()<cr>",
  { desc = "[F]ind recently [O]pened files" }
)
vim.keymap.set(
  "n",
  "<leader><space>",
  "<cmd>lua require('telescope.builtin').buffers()<cr>",
  { desc = "[] Find  buffer" }
)
vim.keymap.set(
  "n",
  "<leader>.",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
  { desc = "[] Fuzzy find in current buffer" }
)
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "[F]ind [F]iles" })
-- vim.keymap.set('n', '<leader>gs', "<cmd>lua require('telescope.builtin').git_status()<cr>", { desc = '[G]it [S]tatus' })
vim.keymap.set(
  "n",
  "<leader>FF",
  "<cmd>lua require('telescope.builtin').find_files({ cwd = vim.env.HOME })<cr>",
  { desc = "[F]ind [F]iles in $HOME" }
)
vim.keymap.set(
  "n",
  "<leader>fh",
  "<cmd>lua require('telescope.builtin').help_tags()<cr>",
  { desc = "[F]ind [H]elp tags" }
)
-- vim.keymap.set('n', '<leader>fw', "<cmd>lua require('telescope.builtin').grep_string()<cr>", { desc = '[F]ind [W]ord under cursor' })
vim.keymap.set(
  "n",
  "<leader>fg",
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { desc = "[F]ind using live [G]rep" }
)
vim.keymap.set(
  "n",
  "<leader>fd",
  "<cmd>lua require('telescope.builtin').diagnostics()<cr>",
  { desc = "[F]ind [D]iagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>fy",
  "<cmd>lua require('telescope').extensions.yank_history.yank_history()<cr>",
  { desc = "[F]ind in [Y]ank history" }
)
vim.keymap.set(
  "n",
  "<leader>fp",
  "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
  { desc = "[F]ind [P]roject" }
)
vim.keymap.set(
  "n",
  "<leader>fu",
  "<cmd>lua require('telescope').extensions.undo.undo()<cr>",
  { desc = "[F]ind in [U]ndo history" }
)
vim.keymap.set("n", "<leader>sr", '<cmd>lua require("spectre").open()<CR>', {
  desc = "[S]earch and [R]eplace",
})
vim.keymap.set("n", "<leader>SR", '<cmd>lua require("spectre").open_file_search()<CR>', {
  desc = "[S]earch and [R]eplace in current file",
})
vim.keymap.set("n", "<leader>fm", "<esc><cmd>Telescope harpoon marks<CR>", {
  desc = "[F]ind [M]arked files",
  noremap = true,
  silent = true,
})
-- vim.keymap.set('n', '<leader>sr', '<cmd>Spectre<cr>', { desc = '[S]earch and [R]eplace' })
-- vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--   desc = 'Search current word',
-- })
-- vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--   desc = 'Search current word',
-- })
-- vim.keymap.set('n', '<leader>tc', '<cmd>TSContextToggle<cr>', { desc = '[T]oggle [C]ontext' })

-- vim.keymap.set('n', '<leader>fg', "<cmd>lua require('telescope.builtin').git_files()<cr>", { desc = '[F]ind [G]it files' })
-- vim.keymap.set(
--   'n',
--   '<leader>ff',
--   "<cmd>lua require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git'})<cr>",
--   { desc = '[F]ind [F]iles in CWD' }
-- )
-- vim.keymap.set('n', '<leader>ff', "<CMD>lua require'telescope-config'.project_files()<CR>", { desc = '[F]ind [F]iles in CWD' })
-- vim.keymap.set(
--   'n',
--   '<leader>fd',
--   "<cmd>lua require('telescope.builtin').find_files( { cwd = vim.env.HOME, find_command = { 'fd', '-td', '-tl', '-uu' }, previewer = false })<cr>",
--   { desc = '[F]ind [D]irectory' }
-- )
-- vim.keymap.set('n', '<leader>rs', "<cmd>lua require('telescope.builtin').resume()<cr>", { desc = '[R]esume [S]earch' })
-- vim.keymap.set('n', '<leader>fc', "<cmd>lua require('telescope.builtin').commands()<cr>", { desc = '[F]ind [U]ndo from history' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      "bash",
      "c",
      "http",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    -- incremental_selection = {
    -- enable = true,
    -- keymaps = {
    --   init_selection = '<c-space>',
    --   node_incremental = '<c-space>',
    --   -- scope_incremental = '<c-s>',
    --   -- node_decremental = '<M-space>',
    -- },
    -- },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- ['aa'] = '@parameter.outer',
          -- ['ia'] = '@parameter.inner',
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      -- move = {
      --   enable = true,
      --   set_jumps = true, -- whether to set jumps in the jumplist
      --   goto_next_start = {
      --     [']m'] = '@function.outer',
      --     [']]'] = '@class.outer',
      --   },
      --   goto_next_end = {
      --     [']M'] = '@function.outer',
      --     [']['] = '@class.outer',
      --   },
      --   goto_previous_start = {
      --     ['[m'] = '@function.outer',
      --     ['[['] = '@class.outer',
      --   },
      --   goto_previous_end = {
      --     ['[M'] = '@function.outer',
      --     ['[]'] = '@class.outer',
      --   },
      -- },
      -- swap = {
      --   enable = true,
      --   swap_next = {
      --     ['<leader>a'] = '@parameter.inner',
      --   },
      --   swap_previous = {
      --     ['<leader>A'] = '@parameter.inner',
      --   },
      -- },
    },

    -- context_commentstring = {
    --   enable = true,
    --   enable_autocmd = false,
    -- config = {
    --   javascript = {
    --     __default = '// %s',
    --     jsx_element = '{/* %s */}',
    --     jsx_fragment = '{/* %s */}',
    --     jsx_attribute = '// %s',
    --     comment = '// %s',
    --   },
    --   typescript = { __default = '// %s', __multiline = '/* %s */' },
    -- },
    -- },
  })
end, 0)

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "[D]iagnostic [N]ext" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "[D]iagnostic [P]revious" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "[D]iagnostic [F]loat" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap("<leader>ca", ":CodeActionMenu<CR>", "[C]ode [A]ction")

  nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  -- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- nmap('K', function()
  --   vim.api.nvim_del_autocmd(auto_diag_float)
  --   auto_diag_float = nil
  --   vim.lsp.buf.hover()
  -- end, 'Hover Documentation')
  -- nmap('<C-k>', function()
  --   vim.api.nvim_del_autocmd(auto_diag_float)
  --   auto_diag_float = nil
  --   vim.lsp.buf.signature_help()
  -- end, 'Signature Documentation')

  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
  --
  -- vim.api.nvim_create_autocmd('BufWritePost', {
  --   pattern = '{[^.]????*,[^o]???*,[^i]??*,[^l]*,[^:]*}',
  --   command = 'Format',
  -- })
end

-- document existing key chains
-- require('which-key').register {
-- ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
-- ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
-- ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
-- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
-- ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
-- ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
-- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup({
  ui = {
    border = "single",
    width = 0.7,
  },
})
require("mason-lspconfig").setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  html = {},

  vimls = {},

  tsserver = {},

  lua_ls = {},

  -- emmet_ls = {},

  -- emmet_language_server = {
  --   filetypes = { "css", "eruby", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "typescriptreact" },
  -- },

  emmet_language_server = {},

  tailwindcss = {},

  eslint = {},

  jsonls = {},

  yamlls = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

vim.diagnostic.config({
  -- virtual_text = {
  --   prefix = "●",
  -- },
  float = {
    border = "single",
  },
})

-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- underline = {
--   severity = { min = vim.diagnostic.severity.WARN },
-- },
-- })

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

-- local get_mw = function()
--   if math.floor(vim.o.columns * 0.1) < 20 then
--     return 20
--   else
--     return math.floor(vim.o.columns * 0.1)
--   end
-- end

local lspkind = require("lspkind")
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text", -- show only symbol annotations
      -- maxwidth = get_mw(), -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      -- symbol_map = { Codeium = '' },

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function(entry, vim_item)
      --   return vim_item
      -- end,
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  window = {
    completion = cmp.config.window.bordered({
      border = "single",
    }),
    documentation = cmp.config.window.bordered({
      border = "single",
    }),
  },
  mapping = cmp.mapping.preset.insert({
    -- ['<C-n>'] = cmp.mapping.select_next_item(),
    -- ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete {},
    ["<C-Space>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.close()
        elseif not cmp.visible() then
          cmp.complete()
        else
          fallback()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.abort()
        elseif not cmp.visible() then
          cmp.complete()
        else
          fallback()
        end
      end,
    }),
    ["<CR>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        else
          fallback()
        end
      end,
      -- c = function(fallback)
      --   if cmp.visible() and cmp.get_active_entry() then
      --     cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
      --   else
      --     fallback()
      --   end
      -- end,
      -- s = cmp.mapping.confirm { select = true },
      -- c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    }),
    ["<Tab>"] = cmp.mapping({
      i = function(fallback)
        -- if cmp.visible() then
        --   cmp.select_next_item()
        -- elseif luasnip.expand_or_locally_jumpable() then
        --   luasnip.expand_or_jump()
        if not cmp.visible() and luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end,
    }),
    ["<S-Tab>"] = cmp.mapping({
      i = function(fallback)
        -- if cmp.visible() then
        --   cmp.select_prev_item()
        -- elseif luasnip.locally_jumpable(-1) then
        --   luasnip.jump(-1)

        if not cmp.visible() and luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
    }),

    ["<down>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      -- s = cmp.mapping.confirm { select = true },
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          fallback()
        end
      end,
    }),

    ["<up>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      -- s = cmp.mapping.confirm { select = true },
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          fallback()
        end
      end,
    }),
  }),
  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      -- entry_filter = function()
      --   local context = require 'cmp.config.context'
      --   return not context.in_treesitter_capture 'comment'
      --     and not context.in_syntax_group 'Comment'
      --     and not context.in_treesitter_capture 'string'
      --     and not context.in_syntax_group 'String'
      -- end,
    },
    {
      name = "luasnip",
      entry_filter = function()
        local context = require("cmp.config.context")
        return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
          and not context.in_treesitter_capture("string")
          and not context.in_syntax_group("String")
      end,
    },
    -- { name = 'buffer' },
    { name = "path" },
    -- { name = 'calc' },
    -- {
    --   name = 'emoji',
    --   option = {
    --     insert = true,
    --   },
    -- },
    -- {
    --   name = 'spell',
    --   option = {
    --     keep_all_entries = false,
    --     enable_in_context = function()
    --       return true
    --     end,
    --   },
    -- },
    -- { name = 'codeium' },
    -- { name = 'cmp_yanky' },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})
cmp.setup.cmdline(":", {
  completion = {
    completeopt = "menu,menuone,noinsert,noselect",
  },
  mapping = cmp.mapping.preset.cmdline({}),
  sources = cmp.config.sources({
    { name = "cmdline" },
    -- { name = 'path' },
    -- { name = 'cmdline_history' },
  }),
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- local cmp = require 'cmp'
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    -- if args.data.filetype ~= 'help' then
    --   vim.wo.number = true
    -- elseif args.data.bufname:match '*.csv' then
    --   vim.wo.wrap = false
    -- end
    vim.wo.number = true
    vim.wo.wrap = true
  end,
})

local signs = {
  --   JetBrains friendly icons
  -- Error = ' ',
  -- Warn = ' ',
  -- Hint = " ",
  -- Info = ' ',

  -- CaskaydiaCove friendly icons
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_augroup("AutoDiagFloat", { clear = true })

-- vim.api.nvim_create_autocmd('CursorHold', {
--   callback = function()
--     if not auto_diag_float then
--       auto_diag_float =
vim.api.nvim_create_autocmd("CursorHold", {
  group = "AutoDiagFloat",
  callback = function()
    if vim.lsp.buf.server_ready() then
      local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
      if next(vim.diagnostic.get(0, { lnum = r - 1 })) ~= nil then
        vim.diagnostic.open_float({
          header = "",
          format = function(diagnostic)
            return string.format("%s", diagnostic.message)
          end,
          suffix = function(diagnostic)
            return string.format(" --> %s [%d:%d]", diagnostic.source, (diagnostic.lnum + 1), diagnostic.col)
          end,

          title = " diagnostics ",
          title_pos = "right",
          focusable = false,
          close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave" },
        })
      end
    end
  end,
})
--     end
--   end,
-- })

-- vim.keymap.set({ "n", "v" }, "<leader>U", function()
--   local url_under_cursor = vim.fn.expand("<cWORD>")
--   if string.match(url_under_cursor, "[a-z]*://[^ >,;]*") then
--     vim.fn.jobstart({ "wslview", url_under_cursor })
--   end
-- end, { noremap = true, desc = "Go to [U]rl under cursor" })

vim.keymap.set({ "n", "v" }, "<C-q>t", "<cmd>tabclose<cr>", { noremap = true, desc = "[Q]uit [T]ab" })
vim.keymap.set({ "n", "v" }, "<leader>dv", "<cmd>DiffviewOpen<cr>", { noremap = true, desc = "[D]iff [V]iew" })
vim.keymap.set({ "n", "v" }, "<leader>L", "<cmd>Lazy<cr>", { noremap = true, desc = "[L]azy" })
vim.keymap.set({ "n", "v" }, "<leader>M", "<cmd>Mason<cr>", { noremap = true, desc = "[M]ason" })

-- vim.cmd("hi DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=#ed8796")
-- vim.cmd("hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl guisp=#eed49f")
-- vim.cmd("hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl guisp=#8bd5ca")
-- vim.cmd("hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl guisp=#91d7e3")
vim.cmd("hi FloatTitle gui=bold guifg=#89b4fa")

-- vim.cmd("set list")
-- vim.cmd("set listchars=leadmultispace:ᐧ")
-- vim.o.list = true
-- vim.o.listchars = "leadmultispace:·"

vim.keymap.set(
  "n",
  "<leader>oc",
  "<cmd>:e /home/mushfiq/.config/nvim/init.lua<cr>",
  { noremap = true, desc = "[O]pen [C]onfig" }
)

require("lspconfig.ui.windows").default_options.border = "single"

-- vim.o.winblend = 7
-- vim.o.pumblend = 7

-- vim.cmd([[
--   vnoremap y mcy`c
-- ]])

-- vim.cmd([[
-- let g:clipboard = {
--     \   'name': 'WslClipboard',
--     \   'copy': {
--     \      '+': 'clip.exe',
--     \      '*': 'clip.exe',
--     \    },
--     \   'paste': {
--     \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     \   },
--     \   'cache_enabled': 0,
--     \ }
-- ]])

-- vim.cmd([[
-- let g:clipboard = {
--   \   'name': 'myClipboard',
--   \   'copy': {
--   \      '+': ['tmux', 'load-buffer', '-'],
--   \      '*': ['tmux', 'load-buffer', '-'],
--   \    },
--   \   'paste': {
--   \      '+': ['tmux', 'save-buffer', '-'],
--   \      '*': ['tmux', 'save-buffer', '-'],
--   \   },
--   \   'cache_enabled': 1,
--   \ }
-- ]])

-- local get_pum = function()
--   if math.floor(vim.o.lines * 0.45) < 15 then
--     return 15
--   else
--     return math.floor(vim.o.lines * 0.45)
--   end
-- end

-- vim.o.pumheight = get_pum()
-- math.floor(vim.o.lines * 0.45)
-- vim.o.pumheight = 13

-- vim.cmd 'hi MatchParen guifg=#ffffff guibg=#7f7f7f'
-- --
-- vim.api.nvim_create_autocmd('InsertEnter', {
--   callback = function()
--     vim.cmd 'hi MatchParen cterm=bold gui=bold guifg=#ff9e64 guibg=NONE'
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('InsertLeave', {
--   callback = function()
--     vim.cmd 'hi MatchParen guifg=#ffffff guibg=#7f7f7f'
--   end,
-- })
--
-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

-- vim.keymap.set('n', '<leader>rll', '<cmd>LspRestart<CR>', { noremap = true, desc = '[R]estart [L]SP server' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
