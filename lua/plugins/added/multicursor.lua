return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  keys = {
    -- Line-based cursors
    -- {
    --   "<up>",
    --   function()
    --     require("multicursor-nvim").lineAddCursor(-1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Add cursor above",
    -- },
    -- {
    --   "<down>",
    --   function()
    --     require("multicursor-nvim").lineAddCursor(1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Add cursor below",
    -- },
    -- {
    --   "<leader><up>",
    --   function()
    --     require("multicursor-nvim").lineSkipCursor(-1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Skip and add cursor above",
    -- },
    -- {
    --   "<leader><down>",
    --   function()
    --     require("multicursor-nvim").lineSkipCursor(1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Skip and add cursor below",
    -- },

    -- Word/selection matching
    {
      "<c-n>",
      function()
        require("multicursor-nvim").matchAddCursor(1)
      end,
      mode = { "n", "x" },
      desc = "Add cursor to next match",
    },
    -- {
    --   "<leader>s",
    --   function()
    --     require("multicursor-nvim").matchSkipCursor(1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Skip to next match",
    -- },
    {
      "<c-p>",
      function()
        require("multicursor-nvim").matchAddCursor(-1)
      end,
      mode = { "n", "x" },
      desc = "Add cursor to previous match",
    },
    -- {
    --   "<leader>S",
    --   function()
    --     require("multicursor-nvim").matchSkipCursor(-1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Skip to previous match",
    -- },

    -- Mouse controls
    {
      "<c-leftmouse>",
      function()
        require("multicursor-nvim").handleMouse()
      end,
      mode = "n",
      desc = "Add/remove cursor (mouse)",
    },
    {
      "<c-leftdrag>",
      function()
        require("multicursor-nvim").handleMouseDrag()
      end,
      mode = "n",
      desc = "Drag to add cursors",
    },
    {
      "<c-leftrelease>",
      function()
        require("multicursor-nvim").handleMouseRelease()
      end,
      mode = "n",
      desc = "Finish mouse operation",
    },

    -- Cursor management
    {
      "<c-q>",
      function()
        require("multicursor-nvim").toggleCursor()
      end,
      mode = { "n", "x" },
      desc = "Toggle cursors",
    },
    -- {
    --   "<leader><c-q>",
    --   function()
    --     require("multicursor-nvim").duplicateCursors()
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Duplicate cursors",
    -- },
    {
      "<leader>gv",
      function()
        require("multicursor-nvim").restoreCursors()
      end,
      mode = "n",
      desc = "Restore cursors",
    },

    -- Operators
    -- {
    --   "ga",
    --   function()
    --     require("multicursor-nvim").addCursorOperator()
    --   end,
    --   mode = "n",
    --   desc = "Add cursors (operator)",
    -- },
    -- {
    --   "<leader>m",
    --   function()
    --     require("multicursor-nvim").operator()
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Custom operator",
    -- },

    -- Visual mode operations
    -- {
    --   "S",
    --   function()
    --     require("multicursor-nvim").splitCursors()
    --   end,
    --   mode = "x",
    --   desc = "Split visual selection",
    -- },
    {
      "M",
      function()
        require("multicursor-nvim").matchCursors()
      end,
      mode = "x",
      desc = "Match in visual selection",
    },
    {
      "I",
      function()
        require("multicursor-nvim").insertVisual()
      end,
      mode = "x",
      desc = "Insert before each line",
    },
    {
      "A",
      function()
        require("multicursor-nvim").appendVisual()
      end,
      mode = "x",
      desc = "Append after each line",
    },

    -- Alignment and transformation
    -- {
    --   "<leader>a",
    --   function()
    --     require("multicursor-nvim").alignCursors()
    --   end,
    --   mode = "n",
    --   desc = "Align cursors",
    -- },
    -- {
    --   "<leader>t",
    --   function()
    --     require("multicursor-nvim").transposeCursors(1)
    --   end,
    --   mode = "x",
    --   desc = "Rotate selections forward",
    -- },
    -- {
    --   "<leader>T",
    --   function()
    --     require("multicursor-nvim").transposeCursors(-1)
    --   end,
    --   mode = "x",
    --   desc = "Rotate selections backward",
    -- },

    -- Sequences
    -- {
    --   "g<c-a>",
    --   function()
    --     require("multicursor-nvim").sequenceIncrement()
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Increment sequence",
    -- },
    -- {
    --   "g<c-x>",
    --   function()
    --     require("multicursor-nvim").sequenceDecrement()
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Decrement sequence",
    -- },
    --
    -- -- Search-based
    -- {
    --   "<leader>/n",
    --   function()
    --     require("multicursor-nvim").searchAddCursor(1)
    --   end,
    --   mode = "n",
    --   desc = "Add cursor to next search",
    -- },
    -- {
    --   "<leader>/N",
    --   function()
    --     require("multicursor-nvim").searchAddCursor(-1)
    --   end,
    --   mode = "n",
    --   desc = "Add cursor to prev search",
    -- },
    -- {
    --   "<leader>/s",
    --   function()
    --     require("multicursor-nvim").searchSkipCursor(1)
    --   end,
    --   mode = "n",
    --   desc = "Skip to next search",
    -- },
    -- {
    --   "<leader>/S",
    --   function()
    --     require("multicursor-nvim").searchSkipCursor(-1)
    --   end,
    --   mode = "n",
    --   desc = "Skip to prev search",
    -- },
    -- {
    --   "<leader>/A",
    --   function()
    --     require("multicursor-nvim").searchAllAddCursors()
    --   end,
    --   mode = "n",
    --   desc = "Add cursors to all matches",
    -- },

    -- Global operations
    {
      "<leader>A",
      function()
        require("multicursor-nvim").matchAllAddCursors()
      end,
      mode = { "n", "x" },
      desc = "Add cursors to all matches in file",
    },

    -- Diagnostics
    -- {
    --   "]d",
    --   function()
    --     require("multicursor-nvim").diagnosticAddCursor(1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Add cursor to next diagnostic",
    -- },
    -- {
    --   "[d",
    --   function()
    --     require("multicursor-nvim").diagnosticAddCursor(-1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Add cursor to prev diagnostic",
    -- },
    -- {
    --   "]s",
    --   function()
    --     require("multicursor-nvim").diagnosticSkipCursor(1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Skip to next diagnostic",
    -- },
    -- {
    --   "[S",
    --   function()
    --     require("multicursor-nvim").diagnosticSkipCursor(-1)
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Skip to prev diagnostic",
    -- },
    -- {
    --   "md",
    --   function()
    --     require("multicursor-nvim").diagnosticMatchCursors({
    --       severity = vim.diagnostic.severity.ERROR,
    --     })
    --   end,
    --   mode = { "n", "x" },
    --   desc = "Add cursors to diagnostics in range",
    -- },
  },
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    -- local set = vim.keymap.set
    --
    -- -- Add or skip cursor above/below the main cursor.
    -- set({ "n", "x" }, "<up>", function()
    --   mc.lineAddCursor(-1)
    -- end)
    -- set({ "n", "x" }, "<down>", function()
    --   mc.lineAddCursor(1)
    -- end)
    -- set({ "n", "x" }, "<leader><up>", function()
    --   mc.lineSkipCursor(-1)
    -- end)
    -- set({ "n", "x" }, "<leader><down>", function()
    --   mc.lineSkipCursor(1)
    -- end)
    --
    -- -- Add or skip adding a new cursor by matching word/selection
    -- set({ "n", "x" }, "<leader>n", function()
    --   mc.matchAddCursor(1)
    -- end)
    -- set({ "n", "x" }, "<leader>s", function()
    --   mc.matchSkipCursor(1)
    -- end)
    -- set({ "n", "x" }, "<leader>N", function()
    --   mc.matchAddCursor(-1)
    -- end)
    -- set({ "n", "x" }, "<leader>S", function()
    --   mc.matchSkipCursor(-1)
    -- end)
    --
    -- -- Add and remove cursors with control + left click.
    -- set("n", "<c-leftmouse>", mc.handleMouse)
    -- set("n", "<c-leftdrag>", mc.handleMouseDrag)
    -- set("n", "<c-leftrelease>", mc.handleMouseRelease)
    --
    -- -- Disable and enable cursors.
    -- set({ "n", "x" }, "<c-q>", mc.toggleCursor)
    --
    -- -- NOTE: ADVANCE KEYMAPS
    -- --
    -- -- Pressing `gaip` will add a cursor on each line of a paragraph.
    -- set("n", "ga", mc.addCursorOperator)
    --
    -- -- Clone every cursor and disable the originals.
    -- set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)
    --
    -- -- Align cursor columns.
    -- set("n", "<leader>a", mc.alignCursors)
    --
    -- -- Split visual selections by regex.
    -- set("x", "S", mc.splitCursors)
    --
    -- -- match new cursors within visual selections by regex.
    -- set("x", "M", mc.matchCursors)
    --
    -- -- bring back cursors if you accidentally clear them
    -- set("n", "<leader>gv", mc.restoreCursors)
    --
    -- -- Add a cursor for all matches of cursor word/selection in the document.
    -- set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors)
    --
    -- -- Rotate the text contained in each visual selection between cursors.
    -- set("x", "<leader>t", function()
    --   mc.transposeCursors(1)
    -- end)
    -- set("x", "<leader>T", function()
    --   mc.transposeCursors(-1)
    -- end)
    --
    -- -- Append/insert for each line of visual selections.
    -- -- Similar to block selection insertion.
    -- set("x", "I", mc.insertVisual)
    -- set("x", "A", mc.appendVisual)
    --
    -- -- Increment/decrement sequences, treaing all cursors as one sequence.
    -- set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement)
    -- set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement)
    --
    -- -- Add a cursor and jump to the next/previous search result.
    -- set("n", "<leader>/n", function()
    --   mc.searchAddCursor(1)
    -- end)
    -- set("n", "<leader>/N", function()
    --   mc.searchAddCursor(-1)
    -- end)
    --
    -- -- Jump to the next/previous search result without adding a cursor.
    -- set("n", "<leader>/s", function()
    --   mc.searchSkipCursor(1)
    -- end)
    -- set("n", "<leader>/S", function()
    --   mc.searchSkipCursor(-1)
    -- end)
    --
    -- -- Add a cursor to every search result in the buffer.
    -- set("n", "<leader>/A", mc.searchAllAddCursors)
    --
    -- -- Pressing `<leader>miwap` will create a cursor in every match of the
    -- -- string captured by `iw` inside range `ap`.
    -- -- This action is highly customizable, see `:h multicursor-operator`.
    -- set({ "n", "x" }, "<leader>m", mc.operator)
    --
    -- -- Add or skip adding a new cursor by matching diagnostics.
    -- set({ "n", "x" }, "]d", function()
    --   mc.diagnosticAddCursor(1)
    -- end)
    -- set({ "n", "x" }, "[d", function()
    --   mc.diagnosticAddCursor(-1)
    -- end)
    -- set({ "n", "x" }, "]s", function()
    --   mc.diagnosticSkipCursor(1)
    -- end)
    -- set({ "n", "x" }, "[S", function()
    --   mc.diagnosticSkipCursor(-1)
    -- end)
    --
    -- -- Press `mdip` to add a cursor for every error diagnostic in the range `ip`.
    -- set({ "n", "x" }, "md", function()
    --   -- See `:h vim.diagnostic.GetOpts`.
    --   mc.diagnosticMatchCursors({ severity = vim.diagnostic.severity.ERROR })
    -- end)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    -- local hl = vim.api.nvim_set_hl
    -- hl(0, "MultiCursorCursor", { link = "Cursor" })
    -- hl(0, "MultiCursorVisual", { link = "Visual" })
    -- hl(0, "MultiCursorSign", { link = "SignColumn" })
    -- hl(0, "MultiCursorMatchPreview", { link = "Search" })
    -- hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    -- hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    -- hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
