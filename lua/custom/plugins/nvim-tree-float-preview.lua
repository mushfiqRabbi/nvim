return {
  "JMarkin/nvim-tree.lua-float-preview",
  lazy = true,
  config = function()
    require("float-preview").setup({
      window = {
        wrap = true,
        open_win_config = function()
          local HEIGHT_RATIO = 0.9
          local WIDTH_RATIO = 0.55
          local FULL_WIDTH_RATIO = 0.8
          return {
            border = "single",
            relative = "editor",
            row = math.floor((vim.o.lines - (vim.o.lines * HEIGHT_RATIO)) / 2),
            col = math.floor((vim.o.columns - (vim.o.columns * FULL_WIDTH_RATIO)) / 2) + math.floor(
              vim.o.columns * 0.25
            ) + 2,
            width = math.floor(vim.o.columns * WIDTH_RATIO),
            height = math.floor(vim.o.lines * HEIGHT_RATIO),
          }
        end,
      },
    })
  end,
}
