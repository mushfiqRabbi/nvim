return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local term_count = 0
    local term_auto_resize_augroup_id = nil
    local is_exit = false
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("n", "<C-c>", "i<C-c>", opts)
      -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      vim.keymap.set("t", "<C-q><C-q>", "<cmd>bd!<cr>", opts)
      vim.keymap.set("n", "<C-q><C-q>", "<cmd>bd!<cr>", opts)
      -- vim.keymap.set('n', 'q', 'iexit<cr>', opts)
      -- vim.keymap.set('t', '<C-w>q', 'exit<cr>', opts)
      -- vim.keymap.set('n', '<C-w>q', 'iexit<cr>', opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    require("toggleterm").setup({
      direction = "float",
      size = function(term)
        if term.direction == "horizontal" then
          if vim.fn.hostname() == "DESKTOP-QP9KQE3" then
            return vim.o.lines * 0.3
          elseif vim.fn.hostname() == "DESKTOP-CKMOCDG" then
            return vim.o.lines * 0.4
          end
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      persist_mode = false,
      persist_size = false,
      open_mapping = [[<c-t>]],
      on_create = function(term)
        if term.direction == "float" then
          return
        end
        -- print('on_create', term.bufnr)
        term_count = term_count + 1
        --         print 'creating'
        --         print(term_count)
      end,
      on_open = function(term)
        if term.direction == "float" then
          return
        end
        -- print('on_open', term.bufnr)
        --         print 'opening'
        --         print(term_count)
        vim.cmd("wincmd p")
        vim.cmd("stopinsert")
        if term_count == 1 or not term_auto_resize_augroup_id then
          term_auto_resize_augroup_id = vim.api.nvim_create_augroup("TermAutoResize", { clear = true })
          vim.api.nvim_create_autocmd("BufEnter", {
            group = "TermAutoResize",
            pattern = "term://*#toggleterm#*",
            callback = function()
              -- print 'entering'
              vim.cmd(string.format("resize %d", math.floor(vim.o.lines * 0.7)))
              -- vim.cmd 'startinsert'
            end,
          })
          vim.api.nvim_create_autocmd("BufLeave", {
            group = "TermAutoResize",
            pattern = "term://*#toggleterm#*",
            callback = function()
              -- print 'leaving'
              if vim.fn.hostname() == "DESKTOP-QP9KQE3" then
                vim.cmd(string.format("resize %d", vim.o.lines * 0.3))
              elseif vim.fn.hostname() == "DESKTOP-CKMOCDG" then
                vim.cmd(string.format("resize %d", vim.o.lines * 0.4))
              end
              -- vim.cmd 'startinsert'
            end,
          })
        end
      end,
      on_close = function(term)
        if term.direction == "float" then
          return
        end
        -- print('on_close', term.bufnr)
        -- vim.api.nvim_del_autocmd(be)
        -- vim.api.nvim_del_autocmd(bl)
        --         print 'closing'
        --         print(term_count)
        if is_exit then
          is_exit = false
          if term_count == 0 then
            vim.api.nvim_del_augroup_by_name("TermAutoResize")
            term_auto_resize_augroup_id = nil
          end
        elseif term_count == 1 then
          vim.api.nvim_del_augroup_by_name("TermAutoResize")
          term_auto_resize_augroup_id = nil
        end
      end,
      on_exit = function(term)
        if term.direction == "float" then
          return
        end
        -- print('on_exit', term)
        term_count = term_count - 1
        is_exit = true
        --         print 'exiting'
        --         print(term_count)
      end,
      highlights = {
        FloatBorder = {
          guifg = "#89b4fa",
        },
      },
      float_opts = {
        width = function()
          return math.floor(vim.o.columns * 0.7)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        -- winblend = 7,
      },
    })
    -- vim.api.nvim_create_autocmd('BufEnter', {
    --   pattern = 'term://*#toggleterm#*',
    --   callback = function(ev)
    --     vim.cmd 'resize'
    --     -- vim.cmd 'startinsert'
    --   end,
    -- })
    -- vim.api.nvim_create_autocmd('BufLeave', {
    --   pattern = 'term://*#toggleterm#*',
    --   callback = function(ev)
    --     vim.cmd(string.format('resize %d', vim.o.lines * 0.4))
    --     -- vim.cmd 'startinsert'
    --   end,
    -- })
  end,
}
