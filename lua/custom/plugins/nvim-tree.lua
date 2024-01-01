return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "JMarkin/nvim-tree.lua-float-preview",
  },
  config = function()
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      local FloatPreview = require("float-preview")
      FloatPreview.attach_nvimtree(bufnr)
      local close_wrap = FloatPreview.close_wrap

      local toggle_term = function()
        local node = api.tree.get_node_under_cursor()
        local root_dir = vim.fn.FindRootDirectory(node.absolute_path)
        if root_dir ~= "" then
          vim.cmd(string.format("ToggleTerm dir=%s", root_dir))
        elseif root_dir == "" and node.type == "file" then
          vim.cmd(string.format("ToggleTerm dir=%s", vim.fn.fnamemodify(node.absolute_path, ":h")))
        else
          vim.cmd(string.format("ToggleTerm dir=%s", node.absolute_path))
        end
      end

      -- DEFAULT MAPPINGS
      vim.keymap.set("n", "<C-]>", close_wrap(api.tree.change_root_to_node), opts("CD"))
      -- vim.keymap.set("n", "<C-e>", close_wrap(api.node.open.replace_tree_buffer), opts("Open: In Place"))
      vim.keymap.set("n", "<C-k>", close_wrap(api.node.show_info_popup), opts("Info"))
      vim.keymap.set("n", "<C-r>", close_wrap(api.fs.rename_sub), opts("Rename: Omit Filename"))
      vim.keymap.set("n", "<C-t>", close_wrap(api.node.open.tab), opts("Open: New Tab"))
      vim.keymap.set("n", "<C-v>", close_wrap(api.node.open.vertical), opts("Open: Vertical Split"))
      vim.keymap.set("n", "<C-x>", close_wrap(api.node.open.horizontal), opts("Open: Horizontal Split"))
      vim.keymap.set("n", "<BS>", close_wrap(api.node.navigate.parent_close), opts("Close Directory"))
      vim.keymap.set("n", "<CR>", close_wrap(api.node.open.edit), opts("Open"))
      vim.keymap.set("n", "<Tab>", close_wrap(api.node.open.preview), opts("Open Preview"))
      vim.keymap.set("n", ">", close_wrap(api.node.navigate.sibling.next), opts("Next Sibling"))
      vim.keymap.set("n", "<", close_wrap(api.node.navigate.sibling.prev), opts("Previous Sibling"))
      vim.keymap.set("n", ".", close_wrap(api.node.run.cmd), opts("Run Command"))
      vim.keymap.set("n", "-", close_wrap(api.tree.change_root_to_parent), opts("Up"))
      vim.keymap.set("n", "a", close_wrap(api.fs.create), opts("Create"))
      vim.keymap.set("n", "bd", close_wrap(api.marks.bulk.delete), opts("Delete Bookmarked"))
      vim.keymap.set("n", "bt", close_wrap(api.marks.bulk.trash), opts("Trash Bookmarked"))
      vim.keymap.set("n", "bmv", close_wrap(api.marks.bulk.move), opts("Move Bookmarked"))
      vim.keymap.set("n", "B", close_wrap(api.tree.toggle_no_buffer_filter), opts("Toggle Filter: No Buffer"))
      vim.keymap.set("n", "c", close_wrap(api.fs.copy.node), opts("Copy"))
      vim.keymap.set("n", "C", close_wrap(api.tree.toggle_git_clean_filter), opts("Toggle Filter: Git Clean"))
      vim.keymap.set("n", "[c", close_wrap(api.node.navigate.git.prev), opts("Prev Git"))
      vim.keymap.set("n", "]c", close_wrap(api.node.navigate.git.next), opts("Next Git"))
      vim.keymap.set("n", "d", close_wrap(api.fs.remove), opts("Delete"))
      vim.keymap.set("n", "D", close_wrap(api.fs.trash), opts("Trash"))
      vim.keymap.set("n", "E", close_wrap(api.tree.expand_all), opts("Expand All"))
      vim.keymap.set("n", "e", close_wrap(api.fs.rename_basename), opts("Rename: Basename"))
      vim.keymap.set("n", "]e", close_wrap(api.node.navigate.diagnostics.next), opts("Next Diagnostic"))
      vim.keymap.set("n", "[e", close_wrap(api.node.navigate.diagnostics.prev), opts("Prev Diagnostic"))
      vim.keymap.set("n", "F", close_wrap(api.live_filter.clear), opts("Clean Filter"))
      vim.keymap.set("n", "f", close_wrap(api.live_filter.start), opts("Filter"))
      vim.keymap.set("n", "g?", close_wrap(api.tree.toggle_help), opts("Help"))
      vim.keymap.set("n", "gy", close_wrap(api.fs.copy.absolute_path), opts("Copy Absolute Path"))
      vim.keymap.set("n", "H", close_wrap(api.tree.toggle_hidden_filter), opts("Toggle Filter: Dotfiles"))
      vim.keymap.set("n", "I", close_wrap(api.tree.toggle_gitignore_filter), opts("Toggle Filter: Git Ignore"))
      vim.keymap.set("n", "J", close_wrap(api.node.navigate.sibling.last), opts("Last Sibling"))
      vim.keymap.set("n", "K", close_wrap(api.node.navigate.sibling.first), opts("First Sibling"))
      vim.keymap.set("n", "m", close_wrap(api.marks.toggle), opts("Toggle Bookmark"))
      vim.keymap.set("n", "mc", close_wrap(api.marks.clear), opts("Clear All Bookmarks"))
      vim.keymap.set("n", "o", close_wrap(api.node.open.edit), opts("Open"))
      vim.keymap.set("n", "O", close_wrap(api.node.open.no_window_picker), opts("Open: No Window Picker"))
      vim.keymap.set("n", "p", close_wrap(api.fs.paste), opts("Paste"))
      vim.keymap.set("n", "P", close_wrap(api.node.navigate.parent), opts("Parent Directory"))
      vim.keymap.set("n", "q", close_wrap(api.tree.close), opts("Close"))
      vim.keymap.set("n", "r", close_wrap(api.fs.rename), opts("Rename"))
      vim.keymap.set("n", "R", close_wrap(api.tree.reload), opts("Refresh"))
      vim.keymap.set("n", "s", close_wrap(api.node.run.system), opts("Run System"))
      vim.keymap.set("n", "S", close_wrap(api.tree.search_node), opts("Search"))
      vim.keymap.set("n", "u", close_wrap(api.fs.rename_full), opts("Rename: Full Path"))
      vim.keymap.set("n", "U", close_wrap(api.tree.toggle_custom_filter), opts("Toggle Filter: Hidden"))
      vim.keymap.set("n", "W", close_wrap(api.tree.collapse_all), opts("Collapse"))
      vim.keymap.set("n", "x", close_wrap(api.fs.cut), opts("Cut"))
      vim.keymap.set("n", "y", close_wrap(api.fs.copy.filename), opts("Copy Name"))
      vim.keymap.set("n", "Y", close_wrap(api.fs.copy.relative_path), opts("Copy Relative Path"))
      vim.keymap.set("n", "<2-LeftMouse>", close_wrap(api.node.open.edit), opts("Open"))
      vim.keymap.set("n", "<2-RightMouse>", close_wrap(api.tree.change_root_to_node), opts("CD"))

      -- CUSTOM MAPPINGS
      vim.keymap.set("n", "<C-t>", close_wrap(toggle_term), opts("Toggle Term"))
      vim.keymap.set("n", "<C-e>", close_wrap(api.tree.close), opts("Close"))
    end

    require("nvim-tree").setup({
      on_attach = my_on_attach,

      sync_root_with_cwd = true,
      view = {
        centralize_selection = true,
        signcolumn = "auto",
        float = {
          enable = true,
          open_win_config = function()
            local HEIGHT_RATIO = 0.9
            local WIDTH_RATIO = 0.25
            local FULL_WIDTH_RATIO = 0.8
            return {
              border = "single",
              relative = "editor",
              row = math.floor((vim.o.lines - (vim.o.lines * HEIGHT_RATIO)) / 2),
              col = math.floor((vim.o.columns - (vim.o.columns * FULL_WIDTH_RATIO)) / 2),
              width = math.floor(vim.o.columns * WIDTH_RATIO),
              height = math.floor(vim.o.lines * HEIGHT_RATIO),
            }
          end,
        },
      },
      renderer = {
        highlight_git = true,
        highlight_diagnostics = true,
        highlight_opened_files = "name",
        highlight_modified = "name",
        highlight_bookmarks = "name",
        highlight_clipboard = "name",
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            git = {
              ignored = "",
            },
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          error = "",
          warning = "",
          hint = "",
          info = "",
        },
      },
      modified = {
        enable = true,
      },
      filters = {
        git_ignored = false,
      },
    })

    -- local api = require("nvim-tree.api")
    -- vim.keymap.set("n", "<C-g>", "<cmd>NvimTreeToggle<CR>", { noremap = true, desc = "Toggle NvimTree" })
    -- vim.keymap.set("i", "<C-g>", "<C-c>:NvimTreeToggle<CR>", { noremap = true, desc = "Toggle NvimTree" })

    -- api.events.subscribe(api.events.Event.FileCreated, function(file)
    --   vim.cmd("edit " .. file.fname)
    -- end)

    -- vim.api.nvim_create_autocmd("QuitPre", {
    --   callback = function()
    --     local tree_wins = {}
    --     local floating_wins = {}
    --     local wins = vim.api.nvim_list_wins()
    --     for _, w in ipairs(wins) do
    --       local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
    --       if bufname:match("NvimTree_") ~= nil then
    --         table.insert(tree_wins, w)
    --       end
    --       if vim.api.nvim_win_get_config(w).relative ~= "" then
    --         table.insert(floating_wins, w)
    --       end
    --     end
    --     if 1 == #wins - #floating_wins - #tree_wins then
    --       -- Should quit, so we close all invalid windows.
    --       for _, w in ipairs(tree_wins) do
    --         vim.api.nvim_win_close(w, true)
    --       end
    --     end
    --   end,
    -- })

    -- vim.api.nvim_create_autocmd('BufEnter', {
    --   -- pattern = 'NvimTree_*',
    --   callback = function(ev)
    --     print(vim.inspect(ev))
    --     print(vim.api.nvim_buf_get_name(0))
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd('BufLeave', {
    --   -- pattern = 'NvimTree_*',
    --   callback = function(ev)
    --     print(vim.inspect(ev))
    --     print(vim.api.nvim_buf_get_name(0))
    --   end,
    -- })

    local tree = require("nvim-tree.api").tree
    vim.keymap.set({ "n", "v" }, "<C-e>", function()
      if not tree.is_visible() then
        tree.open()
      end
    end, { noremap = true, silent = true, desc = "[] Explore files/folders" })
    vim.keymap.set("i", "<C-e>", function()
      if not tree.is_visible() then
        vim.cmd("stopinsert")
        tree.open()
      end
    end, { noremap = true, silent = true, desc = "[] Explore files/folders" })
  end,
}
