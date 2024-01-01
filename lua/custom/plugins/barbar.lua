return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  version = "^1.0.0", -- optional: only update when a new 1.x version is released
  init = function()
    vim.g.barbar_auto_setup = false
  end,

  config = function()
    require("barbar").setup({
      icons = {
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
          [vim.diagnostic.severity.HINT] = { enabled = true, icon = " " },
        },
      },
    })

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map({ "n", "v", "i" }, "<C-h>", "<Cmd>BufferPrevious<CR>", opts)
    map({ "n", "v", "i" }, "<C-l>", "<Cmd>BufferNext<CR>", opts)
    -- Re-order to previous/next
    map({ "n", "v", "i" }, "<A-,>", "<Cmd>BufferMovePrevious<CR>", opts)
    map({ "n", "v", "i" }, "<A-.>", "<Cmd>BufferMoveNext<CR>", opts)
    -- Goto buffer in position...
    map({ "n", "v", "i" }, "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
    map({ "n", "v", "i" }, "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
    map({ "n", "v", "i" }, "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
    map({ "n", "v", "i" }, "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
    map({ "n", "v", "i" }, "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
    map({ "n", "v", "i" }, "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
    map({ "n", "v", "i" }, "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
    map({ "n", "v", "i" }, "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
    map({ "n", "v", "i" }, "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
    map({ "n", "v", "i" }, "<A-0>", "<Cmd>BufferLast<CR>", opts)
    -- Pin/unpin buffer
    map({ "n", "v", "i" }, "<A-p>", "<Cmd>BufferPin<CR>", opts)
    -- Close buffer
    map({ "n", "v", "i" }, "<C-q><C-q>", "<Cmd>BufferClose<CR>", opts)
    map({ "n", "v", "i" }, "<C-q>o", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
    map({ "n", "v", "i" }, "<C-q>h", "<Cmd>BufferCloseBuffersLeft<CR>", opts)
    map({ "n", "v", "i" }, "<C-q>l", "<Cmd>BufferCloseBuffersRight<CR>", opts)
    -- Wipeout buffer
    --                 :BufferWipeout
    -- Close commands
    --                 :BufferCloseAllButCurrent
    --                 :BufferCloseAllButPinned
    --                 :BufferCloseAllButCurrentOrPinned
    --                 :BufferCloseBuffersLeft
    --                 :BufferCloseBuffersRight
    -- Magic buffer-picking mode
    map({ "n", "v", "i" }, "<C-p>", "<Cmd>BufferPick<CR>", opts)
    -- Sort automatically by...
    map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
    map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
    map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
    map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

    -- Other:
    -- :BarbarEnable - enables barbar (enabled by default)
    -- :BarbarDisable - very bad command, should never be used
  end,
}
