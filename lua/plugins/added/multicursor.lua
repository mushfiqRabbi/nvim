return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  keys = {
    -- Word/selection matching
    {
      "<c-n>",
      function()
        require("multicursor-nvim").matchAddCursor(1)
      end,
      mode = { "n", "x" },
      desc = "Add cursor to next match",
    },
    {
      "<c-p>",
      function()
        require("multicursor-nvim").matchAddCursor(-1)
      end,
      mode = { "n", "x" },
      desc = "Add cursor to previous match",
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

    -- Global operations
    {
      "<leader>A",
      function()
        require("multicursor-nvim").matchAllAddCursors()
      end,
      mode = { "n", "x" },
      desc = "Add cursors to all matches in file",
    },
  },
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

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
  end,
}
